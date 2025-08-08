extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -700.0

@export var bullet_scene: PackedScene
@export var fire_rate: float = 0.1

@onready var muzzle = $Muzzle  # Marker2D where bullets spawn

var fire_cooldown: float = 0.0

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, 8)

	move_and_slide()

func _process(delta: float) -> void:
	fire_cooldown -= delta
	if Input.is_action_pressed("shoot") and fire_cooldown <= 0.0:
		shoot()
		fire_cooldown = fire_rate

func shoot() -> void:
	if bullet_scene == null:
		push_error("No bullet_scene assigned to Player!")
		return

	var bullet = bullet_scene.instantiate()
	bullet.global_position = muzzle.global_position
	bullet.direction = Vector2.LEFT
	get_parent().add_child(bullet)
