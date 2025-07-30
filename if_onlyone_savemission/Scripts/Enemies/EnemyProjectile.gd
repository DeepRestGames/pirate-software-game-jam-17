extends RigidBody2D


var player: Player
@export var PROJECTILE_SPEED: float = 300
var direction: Vector2


func _ready() -> void:
	player = get_tree().get_first_node_in_group("Player")
	direction = to_local(player.global_position).normalized()
	rotation = direction.angle()


func _physics_process(delta: float) -> void:
	var collision = move_and_collide(direction * PROJECTILE_SPEED * delta)
	
	if collision != null:
		call_deferred("queue_free")
