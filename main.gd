extends Node2D

@onready var enemy_scene := preload("res://Enemy.tscn")

func _ready():
	print("Main scene ready")
	_spawn_enemy()

func _spawn_enemy():
	var enemy = enemy_scene.instantiate()
	add_child(enemy)
	enemy.global_position = Vector2(173.0, 590.0)
	print("Enemy created at: ", enemy.global_position)

func _process(delta):
	if has_node("Enemy"):  # Or check your actual enemy node name
		print("Enemy exists in tree at: ", $Enemy.global_position)
