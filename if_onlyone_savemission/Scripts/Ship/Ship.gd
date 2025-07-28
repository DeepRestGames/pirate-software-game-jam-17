extends Node2D


@onready var animation_player = $AnimationPlayer
@onready var ship_visible_area = $ShipVisibleArea


func _on_ship_interaction_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		EventBus.emit_signal("show_ship_interaction_prompt", true)


func _on_ship_interaction_area_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		EventBus.emit_signal("show_ship_interaction_prompt", false)


func _on_ship_visible_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		animation_player.play("Appear")
		
		await animation_player.animation_finished
		play_idle_visible_animation()


func play_idle_visible_animation() -> void:
	for body in ship_visible_area.get_overlapping_bodies():
		if body.is_in_group("Player"):
			animation_player.play("IdleVisible")


func _on_ship_visible_area_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		animation_player.play_backwards("Appear")
		
		await animation_player.animation_finished
		play_idle_invisible_animation()


func play_idle_invisible_animation() -> void:
	for body in ship_visible_area.get_overlapping_bodies():
		if body.is_in_group("Player"):
			return
	
	animation_player.play("IdleInvisible")
