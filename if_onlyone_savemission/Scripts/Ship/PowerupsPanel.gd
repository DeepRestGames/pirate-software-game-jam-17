extends Control


enum PowerupID {
	hp,
	speed,
	ammo
}


# HP
@onready var hp_powerup_slots = [ 
	$VBoxContainer/HP/PowerupSlots/PowerupSlot1, 
	$VBoxContainer/HP/PowerupSlots/PowerupSlot2, 
	$VBoxContainer/HP/PowerupSlots/PowerupSlot3, 
	$VBoxContainer/HP/PowerupSlots/PowerupSlot4, 
	$VBoxContainer/HP/PowerupSlots/PowerupSlot5 
]
@onready var hp_cost_label = $VBoxContainer/HP/HBoxContainer/HPCostLabel
var powerup_hp_level = 0
var powerup_hp_cost = [1, 20, 30, 50, 80]

# Speed
@onready var speed_powerup_slots = [ 
	$VBoxContainer/Speed/PowerupSlots/PowerupSlot1, 
	$VBoxContainer/Speed/PowerupSlots/PowerupSlot2, 
	$VBoxContainer/Speed/PowerupSlots/PowerupSlot3, 
	$VBoxContainer/Speed/PowerupSlots/PowerupSlot4, 
	$VBoxContainer/Speed/PowerupSlots/PowerupSlot5 
]
@onready var speed_cost_label = $VBoxContainer/Speed/HBoxContainer/SpeedCostLabel
var powerup_speed_level = 0
var powerup_speed_cost = [1, 20, 30, 50, 80]

# Ammo
@onready var ammo_powerup_slots = [ 
	$VBoxContainer/Ammo/PowerupSlots/PowerupSlot1, 
	$VBoxContainer/Ammo/PowerupSlots/PowerupSlot2, 
	$VBoxContainer/Ammo/PowerupSlots/PowerupSlot3, 
	$VBoxContainer/Ammo/PowerupSlots/PowerupSlot4, 
	$VBoxContainer/Ammo/PowerupSlots/PowerupSlot5 
]
@onready var ammo_cost_label = $VBoxContainer/Ammo/HBoxContainer/AmmoCostLabel
var powerup_ammo_level = 0
var powerup_ammo_cost = [1, 20, 30, 50, 80]


func _ready() -> void:
	hp_cost_label.text = str(powerup_hp_cost[powerup_hp_level])
	speed_cost_label.text = str(powerup_speed_cost[powerup_speed_level])
	ammo_cost_label.text = str(powerup_ammo_cost[powerup_ammo_level])
	
	EventBus.connect("level_up_powerup_completed", level_up_powerup_completed)


func _on_hp_level_up_button_pressed() -> void:
	EventBus.emit_signal("level_up_powerup", PowerupID.hp, powerup_hp_cost[powerup_hp_level])


func _on_speed_level_up_button_pressed() -> void:
	EventBus.emit_signal("level_up_powerup", PowerupID.speed, powerup_speed_cost[powerup_speed_level])


func _on_ammo_level_up_button_pressed() -> void:
	EventBus.emit_signal("level_up_powerup", PowerupID.ammo, powerup_ammo_cost[powerup_ammo_level])


func level_up_powerup_completed(powerup_ID: PowerupID, level):
	match powerup_ID:
		PowerupID.hp:
			for i in level:
				hp_powerup_slots[i].modulate = Color(0.208, 1.0, 0.208)
			powerup_hp_level += 1
			hp_cost_label.text = str(powerup_hp_cost[powerup_hp_level])
		
		PowerupID.speed:
			for i in level:
				speed_powerup_slots[i].modulate = Color(0.208, 1.0, 0.208)
			powerup_speed_level += 1
			speed_cost_label.text = str(powerup_speed_cost[powerup_speed_level])
		
		PowerupID.ammo:
			for i in level:
				ammo_powerup_slots[i].modulate = Color(0.208, 1.0, 0.208)
			powerup_ammo_level += 1
			ammo_cost_label.text = str(powerup_ammo_cost[powerup_ammo_level])
