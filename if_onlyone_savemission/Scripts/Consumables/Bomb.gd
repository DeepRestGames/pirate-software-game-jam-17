extends Node2D


@onready var animation_player = $AnimationPlayer
@onready var hitbox_area = $HitboxArea

@export var bomb_damage = 3


func _ready() -> void:
	animation_player.play("tick_boom")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "tick_boom":
		for body in hitbox_area.get_overlapping_bodies():
			body.take_damage(3)
	
	call_deferred("queue_free")
