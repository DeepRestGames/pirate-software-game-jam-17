extends RigidBody2D


@export var PROJECTILE_SPEED: float = 400
var direction: Vector2


func _ready() -> void:
	var mouse_position = get_global_mouse_position()
	direction = (mouse_position - global_position).normalized()


func _physics_process(delta: float) -> void:
	
	var collision = move_and_collide(direction * PROJECTILE_SPEED * delta)
	
	if collision != null:
		if collision.get_collider().collision_layer == 2:
			pass
			#EventBus.emit_signal("spawn_spark_particles", global_position)
			#EventBus.emit_signal("play_projectile_deflect_sfx")
		else:
			queue_free()
