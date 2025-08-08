class_name Enemy
extends RigidBody2D
var start_position: Vector2

@export var move_speed: float = 5.0
@export var max_hits: int = 1

signal enemy_died

var hits: int = 0

func _ready():
	add_to_group("enemies")
	lock_rotation = true  # Stop spinning
	mass = 0.5  # Lower mass for easier movement
	gravity_scale = 0.0  # Disable gravity if not needed
	print("Enemy spawned at: ", global_position)

func _physics_process(delta):
	# Reset all forces/velocity each frame for consistent movement
	linear_velocity = Vector2.ZERO
	apply_central_impulse(Vector2(move_speed * delta * 1000, 0))

func register_hit():
	hits += 1
	print("Enemy hit! Hits: ", hits, "/", max_hits)
	if hits >= max_hits:
		print("Emitting enemy_died signal")
		emit_signal("enemy_died")
		queue_free()
		

func _on_death():
	# Code to handle death (e.g., animation, state change)
	respawn()

func respawn():
	global_position = start_position
