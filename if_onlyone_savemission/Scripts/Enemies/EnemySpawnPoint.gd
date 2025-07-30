extends Area2D


@onready var enemies_parent_node = $EnemiesParentNode
@onready var enemies_spawn_timer = $EnemiesSpawnTimer as Timer
#@onready var enemy_spawn_buildup_particles = $EnemySpawnBuildup_GPUParticles2D as GPUParticles2D
#@onready var enemy_spawn_flare_particles = $EnemySpawnFlare_GPUParticles2D as GPUParticles2D

@export var enemy_scenes: Array[PackedScene]
@export_custom(PROPERTY_HINT_NONE, "suffix:s") var spawn_cooldown: float = 3

@export var hp: int = 5

@export var drop_rate := 1
var fabricatorMaterialScene = preload("res://Scenes/Consumables/FabricatorMaterial.tscn")


func _ready() -> void:
	enemies_spawn_timer.wait_time = spawn_cooldown
	
	#if enemy_scene != null:
		#enemy_spawn_buildup_particles.lifetime = spawn_cooldown
		#enemy_spawn_buildup_particles.restart()
	
	# Pretty ugly, but needed to fix first time instancing stuttering
	#enemy_spawn_buildup_particles.emitting = true
	#enemy_spawn_buildup_particles.emitting = false
	#enemy_spawn_flare_particles.emitting = true
	#enemy_spawn_flare_particles.emitting = fals


func _on_enemies_spawn_timer_timeout() -> void:
	var enemy_instance = enemy_scenes.pick_random().instantiate()
	enemies_parent_node.add_child(enemy_instance)
	EventBus.emit_signal("play_enemy_spawn_sound")
	
	#enemy_spawn_flare_particles.restart()
	
	#if not enemies_spawn_timer.is_stopped():
		#enemy_spawn_buildup_particles.restart()


func take_damage(value) -> void:
	hp -= value
	if hp <= 0:
		if randf_range(0, 1) <= drop_rate:
			drop_material()
		
		queue_free()


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("PlayerProjectile"):
		body.queue_free()
		take_damage(1)


func drop_material() -> void:
	var dropInstance = fabricatorMaterialScene.instantiate()
	dropInstance.global_position = global_position
	get_tree().current_scene.call_deferred("add_child", dropInstance)


func _on_aggro_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		enemies_spawn_timer.start()


func _on_aggro_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		enemies_spawn_timer.stop()
