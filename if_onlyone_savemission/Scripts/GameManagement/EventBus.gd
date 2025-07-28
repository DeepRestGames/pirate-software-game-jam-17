extends Node


# Add signals here to be triggered from any script


# Combat
@warning_ignore("unused_signal")
signal player_death

@warning_ignore("unused_signal")
signal player_shoot

@warning_ignore("unused_signal")
signal is_reloading(value)

@warning_ignore("unused_signal")
signal screen_shake(magnitude, duration)

@warning_ignore("unused_signal")
signal difficulty_ramp_up

@warning_ignore("unused_signal")
signal difficulty_down

@warning_ignore("unused_signal")
signal final_boss_defeated


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


# Consumables
@warning_ignore("unused_signal")
signal add_fabricator_material(value)

@warning_ignore("unused_signal")
signal remove_fabricator_material(value)

@warning_ignore("unused_signal")
signal send_powerup_global_position(powerup_global_position)

@warning_ignore("unused_signal")
signal add_powerup_chip(value)

@warning_ignore("unused_signal")
signal remove_powerup_chip(value)

@warning_ignore("unused_signal")
signal add_potion(value)

@warning_ignore("unused_signal")
signal remove_potion(value)

@warning_ignore("unused_signal")
signal add_bomb(value)

@warning_ignore("unused_signal")
signal remove_bomb(value)


# Particles
@warning_ignore("unused_signal")
signal spawn_spark_particles(global_position)

@warning_ignore("unused_signal")
signal spawn_blood_particles(global_position)


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
