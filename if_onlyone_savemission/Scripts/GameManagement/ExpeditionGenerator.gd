extends Node2D


var map_size: Vector2
const origin = Vector2.ZERO

# Environmental obstacles
@onready var navigation_region = $"../NavigationRegion2D"
@export var environmental_obstacles: Array[PackedScene]
const min_number_environmental_obstacles = 1000
const max_number_environmental_obstacles = 5000

# Enemies
@onready var enemies_parent = $"../Enemies"
var enemy_spawner_scene = preload("res://Scenes/Enemies/EnemySpawnPoint.tscn")
const min_number_enemy_spawners = 2500
const max_number_enemy_spawners = 4000

# Ground features
@onready var ground_features_parent = $"../GroundFeatures"
var ground_tiles_texture = preload("res://Assets/Sprites/GroundTexture.png")
const min_number_ground_tiles = 20000
const max_number_ground_tiles = 30000


func _ready() -> void:
	navigation_region.connect("bake_finished", on_navigation_region_bake_finished)
	map_size = Vector2(50000, 50000)
	generate_new_expedition()


func generate_new_expedition() -> void:
	position_environmental_obstacles()
	position_enemy_spawners()
	position_ground_tiles()


func position_environmental_obstacles() -> void:
	var environmental_obstacles_number = randi_range(min_number_environmental_obstacles, max_number_environmental_obstacles)
	
	for i in environmental_obstacles_number:
		var x_coordinate = randf_range(-map_size.x, map_size.x)
		var y_coordinate = randf_range(-map_size.y, map_size.y)
		
		var environmental_obstacle_instance = environmental_obstacles.pick_random().instantiate()
		environmental_obstacle_instance.global_position = Vector2(x_coordinate, y_coordinate)
		navigation_region.add_child(environmental_obstacle_instance)
	
	navigation_region.bake_navigation_polygon()


func on_navigation_region_bake_finished() -> void:
	print("Navigation region is ready!")


func position_enemy_spawners() -> void:
	var enemy_spawners_number = randi_range(min_number_enemy_spawners, max_number_enemy_spawners)
	
	for i in enemy_spawners_number:
		var spawner_position = calculate_enemy_spawner_position()
		
		var enemy_spawner_instance = enemy_spawner_scene.instantiate()
		enemy_spawner_instance.global_position = spawner_position
		enemies_parent.add_child(enemy_spawner_instance)


func calculate_enemy_spawner_position() -> Vector2:
	var x_coordinate = randf_range(-map_size.x, map_size.x)
	var y_coordinate = randf_range(-map_size.y, map_size.y)
	var result_vector = Vector2(x_coordinate, y_coordinate)
	
	if int(result_vector.distance_to(origin)) / 1000 < 1:
		return calculate_enemy_spawner_position()
	else:
		return result_vector


func position_ground_tiles() -> void:
	var ground_tiles_number = randi_range(min_number_ground_tiles, max_number_ground_tiles)
	
	for i in ground_tiles_number:
		generate_ground_tile()


func generate_ground_tile() -> void:
	var tile_sprite = Sprite2D.new()
	tile_sprite.texture = ground_tiles_texture
	tile_sprite.hframes = 6
	tile_sprite.frame = randi_range(0, 5)
	tile_sprite.modulate.v = randf_range(0, 1)
	
	var x_coordinate = randf_range(-map_size.x, map_size.x)
	var y_coordinate = randf_range(-map_size.y, map_size.y)
	var result_vector = Vector2(x_coordinate, y_coordinate)
	
	tile_sprite.global_position = result_vector
	ground_features_parent.add_child(tile_sprite)
