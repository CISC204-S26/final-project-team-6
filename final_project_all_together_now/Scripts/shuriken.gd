extends Node2D
var direction = Vector2(0,0)
var shurikenSpeed = 8.0
var damage = 2

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	position += direction * shurikenSpeed


func _on_area_2d_area_entered(area: Area2D) -> void:
	var parent = area.get_parent()
	if parent.has_method("take_damage"):
		parent.take_damage(damage)
		queue_free()
