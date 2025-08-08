extends Area2D

@export var speed: float = 400.0
var direction: Vector2 = Vector2.RIGHT

func _process(delta):
	position += direction * speed * delta
	if not get_viewport_rect().has_point(global_position):
		queue_free()

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("enemies"):
		if body.has_method("register_hit"):
			body.register_hit()
		queue_free()
