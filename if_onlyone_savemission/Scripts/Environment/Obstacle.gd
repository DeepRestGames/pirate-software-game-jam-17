extends StaticBody2D


@export var hp = 10


func take_damage() -> void:
	hp -= 1

	if hp <= 0:
		queue_free()


func _on_hitbox_body_entered(body: Node2D) -> void:
	print("Obstacle hit")
	
	if body.is_in_group("PlayerProjectile"):
		body.queue_free()
		take_damage()
