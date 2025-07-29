extends StaticBody2D


@export var hp = 10
@export var drop_rate := .8
var fabricatorMaterialScene = preload("res://Scenes/Consumables/FabricatorMaterial.tscn")


func take_damage() -> void:
	hp -= 1

	if hp <= 0:
		if randf_range(0, 1) <= drop_rate:
			drop_material()
		
		queue_free()


func drop_material() -> void:
	var dropInstance = fabricatorMaterialScene.instantiate()
	dropInstance.global_position = global_position
	get_tree().current_scene.call_deferred("add_child", dropInstance)


func _on_hitbox_body_entered(body: Node2D) -> void:
	if body.is_in_group("PlayerProjectile"):
		if body.has_method("on_impact"):
			body.on_impact()
		take_damage()
