extends Node


# Add signals here to be triggered from any script


# Combat
@warning_ignore("unused_signal")
signal player_death

@warning_ignore("unused_signal")
signal player_shoot

@warning_ignore("unused_signal")
signal player_reload

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



# Interactables
@warning_ignore("unused_signal")
signal send_gateway_global_position(gateway_global_position)

@warning_ignore("unused_signal")
signal start_opening_gateway

@warning_ignore("unused_signal")
signal gateway_time_left(time_left)

@warning_ignore("unused_signal")
signal gateway_on_screen

@warning_ignore("unused_signal")
signal gateway_off_screen


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
