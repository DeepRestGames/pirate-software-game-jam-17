extends Control


var arrow_hint_powerup_scene = preload("res://Scenes/UI/ArrowHintPowerup.tscn")
@onready var arrow_hint_powerups_parent = $ArrowHintPowerups


func _ready() -> void:
	EventBus.connect("send_powerup_global_position", add_powerup_arrow_hint)
	EventBus.connect("clear_powerup_positions", clear_powerup_positions)


func add_powerup_arrow_hint(powerup_global_position) -> void:
	var arrow_hint_instance = arrow_hint_powerup_scene.instantiate() as ArrowHintPowerupChip
	arrow_hint_instance.powerup_position = powerup_global_position
	add_child(arrow_hint_instance)


func clear_powerup_positions() -> void:
	for i in arrow_hint_powerups_parent.get_children():
		i.queue_free()
