extends StaticBody2D


var player: Player
@export var PROJECTILE_SPEED: float = 200
var direction: Vector2


func _ready() -> void:
	player = get_tree().get_first_node_in_group("Player")	
	direction = to_local(player.global_position).normalized()


func _physics_process(delta: float) -> void:
	rotate(.2)
	
	var collision = move_and_collide(direction * PROJECTILE_SPEED * delta)
	
	if collision != null:
		if collision.get_collider().collision_layer == 2:
			pass
			#EventBus.emit_signal("spawn_spark_particles", global_position)
			#EventBus.emit_signal("play_projectile_deflect_sfx")
		
		queue_free()
