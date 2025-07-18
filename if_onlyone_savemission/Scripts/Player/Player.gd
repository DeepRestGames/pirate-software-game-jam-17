class_name Player
extends CharacterBody2D


@onready var player_sprite = $PlayerSprite

var projectile = preload("res://Scenes/Player/PlayerProjectile.tscn")


var movement_speed: float = 300
var looking_direction = Vector2.ZERO
const ROTATION_SPEED: float = 2


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("shoot"):
		shoot()


func get_movement_input() -> void:
	var input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = input_direction * movement_speed


func _physics_process(delta: float) -> void:
	
	var mouse_position = get_global_mouse_position()
	looking_direction = (mouse_position - global_position).normalized()
	
	get_movement_input()
	move_and_slide()
	
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		
		if collision.get_collider().is_in_group("Enemies"):
			take_damage()


func take_damage() -> void:
	print("Player death")
	EventBus.emit_signal("player_death")
	process_mode = Node.PROCESS_MODE_DISABLED


func shoot() -> void:
	var projectile_instance = projectile.instantiate()
	projectile_instance.global_position = position
	get_parent().add_child(projectile_instance)
