extends Control


var arrow_hint_powerup_scene = preload("res://Scenes/UI/ArrowHintPowerup.tscn")


func _ready() -> void:
	EventBus.connect("send_powerup_global_position", add_powerup_arrow_hint)


func add_powerup_arrow_hint(powerup_global_position) -> void:
	var arrow_hint_instance = arrow_hint_powerup_scene.instantiate() as ArrowHintPowerupChip
	arrow_hint_instance.powerup_position = powerup_global_position
	add_child(arrow_hint_instance)
