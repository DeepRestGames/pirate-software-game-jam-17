extends RigidBody2D


@export var PROJECTILE_SPEED: float = 600
var direction: Vector2


func _ready() -> void:
	var mouse_position = get_global_mouse_position()
	direction = (mouse_position - global_position).normalized()
	rotation = direction.angle()


func _physics_process(delta: float) -> void:
	var collision = move_and_collide(direction * PROJECTILE_SPEED * delta)
	
	if collision != null:
		call_deferred("queue_free")
