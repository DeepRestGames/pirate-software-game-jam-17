extends Control


var player: Player

# Potions
@onready var current_potions_number_label = $VBoxContainer/PotionCrafting/CurrentPotionsNumber
@onready var potion_material_cost_label = $VBoxContainer/PotionCrafting/VBoxContainer/HBoxContainer/FabricatorMaterialCost
@export var potion_material_cost = 3

# Bombs
@onready var current_bombs_number_label = $VBoxContainer/BombsCrafting/CurrentBombsNumber
@onready var bombs_material_cost_label = $VBoxContainer/BombsCrafting/VBoxContainer/HBoxContainer/FabricatorMaterialCost
@export var bombs_material_cost = 6


func _ready() -> void:
	player = get_tree().get_first_node_in_group("Player")
	potion_material_cost_label.text = "x " + str(potion_material_cost)
	bombs_material_cost_label.text = "x " + str(bombs_material_cost)


func _on_craft_potion_button_pressed() -> void:
	if player.fabricator_material_quantity >= potion_material_cost:
		EventBus.emit_signal("remove_fabricator_material", potion_material_cost)
		EventBus.emit_signal("add_potion", 1)
		update_consumables_quantities()


func _on_craft_bomb_button_pressed() -> void:
	if player.fabricator_material_quantity >= bombs_material_cost:
		EventBus.emit_signal("remove_fabricator_material", bombs_material_cost)
		EventBus.emit_signal("add_bomb", 1)
		update_consumables_quantities()


func _on_visibility_changed() -> void:
	update_consumables_quantities()


func update_consumables_quantities() -> void:
	current_potions_number_label.text = "x " + str(player.potions_quantity)
	current_bombs_number_label.text = "x " + str(player.bombs_quantity)
