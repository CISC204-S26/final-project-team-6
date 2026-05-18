extends Node2D
var direction = Vector2(0, 0)
var damage = 3

func _ready() -> void:
	rotation = direction.angle()
	await get_tree().create_timer(0.2).timeout
	queue_free()

func _on_area_2d_area_entered(area: Area2D) -> void:
	var parent = area.get_parent()
	if parent.has_method("take_damage"):
		parent.take_damage(damage)
		queue_free()
