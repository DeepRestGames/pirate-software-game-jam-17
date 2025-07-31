extends Node


# Add signals here to be triggered from any script


# Combat
@warning_ignore("unused_signal")
signal player_death

@warning_ignore("unused_signal")
signal player_respawned

@warning_ignore("unused_signal")
signal player_shoot

@warning_ignore("unused_signal")
signal is_reloading(value)

@warning_ignore("unused_signal")
signal screen_shake(magnitude, duration)

@warning_ignore("unused_signal")
signal clear_map_from_enemies


# UI
@warning_ignore("unused_signal")
signal update_current_ammo(current_ammo)

@warning_ignore("unused_signal")
signal update_max_ammo(max_ammo)

@warning_ignore("unused_signal")
signal update_current_fabricator_material_count(value)

@warning_ignore("unused_signal")
signal update_current_powerup_chips_count(value)

@warning_ignore("unused_signal")
signal update_current_potions_count(value)

@warning_ignore("unused_signal")
signal update_current_bombs_count(value)

@warning_ignore("unused_signal")
signal update_current_hp_HUD(value)

@warning_ignore("unused_signal")
signal update_max_hp_HUD(value)


# Ship
@warning_ignore("unused_signal")
signal show_ship_interaction_prompt(value)

@warning_ignore("unused_signal")
signal show_ship_menu(value)

@warning_ignore("unused_signal")
signal move_ship


# Consumables
@warning_ignore("unused_signal")
signal add_fabricator_material(value)

@warning_ignore("unused_signal")
signal remove_fabricator_material(value)

@warning_ignore("unused_signal")
signal send_powerup_global_position(powerup_global_position)

@warning_ignore("unused_signal")
signal clear_powerup_positions

@warning_ignore("unused_signal")
signal add_powerup_chip(value)

@warning_ignore("unused_signal")
signal remove_powerup_chip(value)

@warning_ignore("unused_signal")
signal level_up_powerup(powerup_ID)

@warning_ignore("unused_signal")
signal level_up_powerup_completed(powerup_ID, powerup_level)

@warning_ignore("unused_signal")
signal add_potion(value)

@warning_ignore("unused_signal")
signal remove_potion(value)

@warning_ignore("unused_signal")
signal add_bomb(value)

@warning_ignore("unused_signal")
signal remove_bomb(value)


# Audio
@warning_ignore("unused_signal")
signal play_music

@warning_ignore("unused_signal")
signal update_music_volume(music_volume)

@warning_ignore("unused_signal")
signal update_sfx_volume(sfx_volume)

@warning_ignore("unused_signal")
signal play_lightning_sfx(volume)

@warning_ignore("unused_signal")
signal play_thunder_sfx

@warning_ignore("unused_signal")
signal play_projectile_deflect_sfx

@warning_ignore("unused_signal")
signal play_gate_open_sfx

@warning_ignore("unused_signal")
signal play_gate_close_sfx

@warning_ignore("unused_signal")
signal play_throw_sound

@warning_ignore("unused_signal")
signal play_pickup_sound

@warning_ignore("unused_signal")
signal play_enemy_spawn_sound

@warning_ignore("unused_signal")
signal play_enemy_death_sound


# Dialogues
@warning_ignore("unused_signal")
signal play_timeline(timeline_name)
