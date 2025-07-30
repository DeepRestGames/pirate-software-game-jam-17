class_name Player
extends CharacterBody2D


# Graphics
@onready var player_sprite = $PlayerSprite
@onready var animation_tree = $AnimationTree
@onready var weapon = $PlayerSprite/Weapon
@onready var muzzle_marker = $PlayerSprite/Weapon/WeaponSprite/MuzzleMarker
#@onready var shooting_animation = $PlayerSprite/Weapon/WeaponSprite/ShootingAnimation
const weapon_x_offset = 15
const weapon_muzzle_x_offset = 10

# Shooting
var projectile = preload("res://Scenes/Player/PlayerProjectile.tscn")
var shooting_animation = preload("res://Scenes/Player/PlayerShootingAnimation.tscn")
var maxAmmo: int = 10
var currentAmmo
var reloadCooldown := 1.5
var currentReloadCooldown : float



# HP
var currentHP: int = 3
@export var maxHP: int = 3
var invincibilityCooldown := .5
var currentInvincibilityCooldown: float

# Movement
var movement_speed: float = 300
var looking_direction = Vector2.ZERO
const ROTATION_SPEED: float = 2

# Consumables
var fabricator_material_quantity: int = 0
var powerup_chips_quantity: int = 0
var potions_quantity: int = 0
var bombs_quantity: int = 10
var bomb_scene = preload("res://Scenes/Consumables/Bomb.tscn")


func _ready() -> void:
	currentAmmo = maxAmmo
	EventBus.emit_signal("update_max_ammo", maxAmmo)
	EventBus.emit_signal("update_current_ammo", currentAmmo)
	
	EventBus.connect("add_fabricator_material", add_fabricator_material)
	EventBus.connect("remove_fabricator_material", remove_fabricator_material)
	
	EventBus.connect("add_powerup_chip", add_powerup_chip)
	EventBus.connect("remove_powerup_chip", remove_powerup_chip)
	
	EventBus.connect("add_potion", add_potion)
	EventBus.connect("remove_potion", remove_potion)
	
	EventBus.connect("add_bomb", add_bomb)
	EventBus.connect("remove_bomb", remove_bomb)
	
	EventBus.emit_signal("update_current_hp_HUD", currentHP)


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("shoot"):
		if currentReloadCooldown <= 0:
			shoot()
	
	if event.is_action_pressed("drink_potion"):
		heal_hp()
	
	if event.is_action_pressed("place_bomb"):
		place_bomb()


func get_movement_input() -> void:
	var input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = input_direction * movement_speed


func _process(delta: float) -> void:
	if currentReloadCooldown > 0:
		currentReloadCooldown -= delta
		
		if currentReloadCooldown <= 0:
			currentAmmo = maxAmmo
			EventBus.emit_signal("update_current_ammo", currentAmmo)
			EventBus.emit_signal("is_reloading", false)
	
	if currentInvincibilityCooldown > 0:
		currentInvincibilityCooldown -= delta


func _physics_process(_delta: float) -> void:
	var mouse_position = get_global_mouse_position()
	looking_direction = (mouse_position - global_position).normalized()
	if looking_direction.x < 0:
		weapon.position.x = - weapon_x_offset
		weapon.scale.y = -0.4
	else:
		weapon.position.x = weapon_x_offset
		weapon.scale.y = 0.4
	
	animation_tree.set("parameters/Run/blend_position", looking_direction)
	
	get_movement_input()
	move_and_slide()


func take_damage(value) -> void:
	if currentInvincibilityCooldown > 0:
		return
	
	remove_hp(value)
	currentInvincibilityCooldown = invincibilityCooldown
	
	var blinking_player_tween = get_tree().create_tween().set_parallel(false)
	blinking_player_tween.tween_property(player_sprite, "visible", false, invincibilityCooldown / 5)
	blinking_player_tween.tween_property(player_sprite, "visible", true, invincibilityCooldown / 5)
	blinking_player_tween.tween_property(player_sprite, "visible", false, invincibilityCooldown / 5)
	blinking_player_tween.tween_property(player_sprite, "visible", true, invincibilityCooldown / 5)
	blinking_player_tween.tween_property(player_sprite, "visible", false, invincibilityCooldown / 5)
	blinking_player_tween.tween_property(player_sprite, "visible", true, .001)
	
	EventBus.emit_signal("screen_shake", 20, 10)


func shoot() -> void:
	var projectile_instance = projectile.instantiate()
	projectile_instance.global_position = muzzle_marker.global_position
	get_parent().add_child(projectile_instance)
	muzzle_marker.add_child(shooting_animation.instantiate())
	
	
	currentAmmo -= 1
	
	EventBus.emit_signal("player_shoot")
	EventBus.emit_signal("update_current_ammo", currentAmmo)
	
	if currentAmmo == 0:
		reload()


func reload() -> void:
	currentReloadCooldown = reloadCooldown
	EventBus.emit_signal("is_reloading", true)


func add_fabricator_material(value) -> void:
	fabricator_material_quantity += value
	EventBus.emit_signal("update_current_fabricator_material_count", fabricator_material_quantity)


func remove_fabricator_material(value) -> void:
	if value > fabricator_material_quantity:
		printerr("Not enough fabricator material!")
		return
	
	fabricator_material_quantity -= value
	EventBus.emit_signal("update_current_fabricator_material_count", fabricator_material_quantity)


func add_powerup_chip(value) -> void:
	powerup_chips_quantity += value
	EventBus.emit_signal("update_current_powerup_chips_count", powerup_chips_quantity)


func remove_powerup_chip(value) -> bool:
	if value > powerup_chips_quantity:
		printerr("Not enough powerup chips!")
		return false
	
	powerup_chips_quantity -= value
	EventBus.emit_signal("update_current_powerup_chips_count", powerup_chips_quantity)
	return true


func add_potion(value) -> void:
	potions_quantity += value
	EventBus.emit_signal("update_current_potions_count", potions_quantity)


func remove_potion(value) -> void:
	if value > potions_quantity:
		printerr("Not enough potions!")
		return
	
	potions_quantity -= value
	EventBus.emit_signal("update_current_potions_count", potions_quantity)


func add_bomb(value) -> void:
	bombs_quantity += value
	EventBus.emit_signal("update_current_bombs_count", bombs_quantity)


func remove_bomb(value) -> void:
	if value > bombs_quantity:
		printerr("Not enough bombs!")
		return
	
	bombs_quantity -= value
	EventBus.emit_signal("update_current_bombs_count", bombs_quantity)


func add_hp(value) -> void:
	currentHP += value
	EventBus.emit_signal("update_current_hp_HUD", currentHP)


func remove_hp(value) -> void:
	currentHP -= value
	EventBus.emit_signal("update_current_hp_HUD", currentHP)
	
	if currentHP <= 0:
		print("Player death")
		EventBus.emit_signal("player_death")
		call_deferred("set_process_mode", Node.PROCESS_MODE_DISABLED)


func heal_hp() -> void:
	if currentHP == maxHP or potions_quantity == 0:
		return
	
	currentHP += 1
	potions_quantity -= 1
	EventBus.emit_signal("update_current_hp_HUD", currentHP)
	EventBus.emit_signal("update_current_potions_count", potions_quantity)


func place_bomb() -> void:
	var bomb_instance = bomb_scene.instantiate()
	bomb_instance.global_position = position
	get_tree().root.add_child(bomb_instance)


func _on_hitbox_body_entered(body: Node2D) -> void:
	if body.is_in_group("Enemies"):
		take_damage(1)
	elif body.is_in_group("EnemyProjectiles"):
		body.queue_free()
		take_damage(1)
