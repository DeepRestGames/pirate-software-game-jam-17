extends StaticBody2D

@onready var sprite = $Sprite2D

@export var hp = 10

func _ready() -> void:
	sprite.frame = randi() % sprite.hframes
	
	
func take_damage() -> void:
	hp -= 1

	if hp <= 0:
		queue_free()


func _on_hitbox_body_entered(body: Node2D) -> void:
	if body.is_in_group("PlayerProjectile"):
		if body.has_method("on_impact"):
			body.on_impact()
		take_damage()
