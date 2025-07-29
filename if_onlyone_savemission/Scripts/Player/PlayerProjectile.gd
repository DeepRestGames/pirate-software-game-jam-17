extends RigidBody2D

@onready var projectile_sprite = $ProjectileSprite
@onready var projectile_glow = $PlayerProjectileGlow

@export var PROJECTILE_SPEED: float = 600
var direction: Vector2
var has_collided := false


func _ready() -> void:
	var mouse_position = get_global_mouse_position()
	direction = (mouse_position - global_position).normalized()
	rotation = direction.angle()


func _physics_process(delta: float) -> void:
	var collision = move_and_collide(direction * PROJECTILE_SPEED * delta)

func on_impact():
	if has_collided:
		return  # Don't trigger twice
	has_collided = true
	
	projectile_glow.visible = false
	PROJECTILE_SPEED = 0
	
	projectile_sprite.flip_v = direction.x < 0
	projectile_sprite.set_animation("explosion")
	projectile_sprite.play()


func _on_projectile_sprite_animation_finished() -> void:
	queue_free()
