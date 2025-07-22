class_name Player
extends CharacterBody2D


# Graphics
@onready var player_sprite = $PlayerSprite

# Shooting
var projectile = preload("res://Scenes/Player/PlayerProjectile.tscn")
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


func _ready() -> void:
	currentAmmo = maxAmmo
	EventBus.emit_signal("update_max_ammo", maxAmmo)
	EventBus.emit_signal("update_current_ammo", currentAmmo)
	
	EventBus.connect("add_fabricator_material", add_fabricator_material)
	EventBus.connect("remove_fabricator_material", remove_fabricator_material)
	
	EventBus.emit_signal("update_current_hp_HUD", currentHP)


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("shoot"):
		if currentReloadCooldown <= 0:
			shoot()
	
	if event.is_action_pressed("drink_potion"):
		full_hp()


func get_movement_input() -> void:
	var input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = input_direction * movement_speed


func _process(delta: float) -> void:
	if currentReloadCooldown > 0:
		currentReloadCooldown -= delta
		
		if currentReloadCooldown <= 0:
			currentAmmo = maxAmmo
			EventBus.emit_signal("update_current_ammo", currentAmmo)
	
	if currentInvincibilityCooldown > 0:
		currentInvincibilityCooldown -= delta


func _physics_process(_delta: float) -> void:
	var mouse_position = get_global_mouse_position()
	looking_direction = (mouse_position - global_position).normalized()
	
	get_movement_input()
	move_and_slide()


func take_damage() -> void:
	if currentInvincibilityCooldown > 0:
		return
	
	remove_hp(1)
	currentInvincibilityCooldown = invincibilityCooldown


func shoot() -> void:
	var projectile_instance = projectile.instantiate()
	projectile_instance.global_position = position
	get_parent().add_child(projectile_instance)
	
	currentAmmo -= 1
	
	EventBus.emit_signal("player_shoot")
	EventBus.emit_signal("update_current_ammo", currentAmmo)
	
	if currentAmmo == 0:
		reload()


func reload() -> void:
	currentReloadCooldown = reloadCooldown


func add_fabricator_material(value) -> void:
	fabricator_material_quantity += value
	EventBus.emit_signal("update_current_fabricator_material_count", fabricator_material_quantity)


func remove_fabricator_material(value) -> void:
	fabricator_material_quantity -= value
	
	if fabricator_material_quantity < 0:
		fabricator_material_quantity = 0
	
	EventBus.emit_signal("update_current_fabricator_material_count", fabricator_material_quantity)


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


func full_hp() -> void:
	currentHP = maxHP
	EventBus.emit_signal("update_current_hp_HUD", currentHP)


func _on_hitbox_body_entered(body: Node2D) -> void:
	if body.is_in_group("Enemies"):
		take_damage()
	elif body.is_in_group("EnemyProjectiles"):
		body.queue_free()
		take_damage()
