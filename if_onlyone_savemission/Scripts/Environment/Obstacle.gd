extends RigidBody2D


@export var hp = 10


func take_damage(value) -> void:
	hp -= value

	if hp <= 0:
		queue_free()


func _on_hitbox_body_entered(body: Node2D) -> void:
	if body.is_in_group("PlayerProjectile"):
		body.queue_free()
		take_damage(1)
