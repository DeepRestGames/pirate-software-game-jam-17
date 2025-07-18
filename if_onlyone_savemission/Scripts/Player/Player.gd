class_name Player
extends CharacterBody2D


@onready var player_sprite = $PlayerSprite


var movement_speed: float = 300
var movement_direction = Vector2.ZERO


func get_movement_input() -> void:
	var input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = input_direction * movement_speed


func _physics_process(delta: float) -> void:
	get_movement_input()
	move_and_slide()
