extends Node2D
@export var direction = Vector2(0,0)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if direction == Vector2 (0,0):
		direction = Vector2(0,0)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position += direction
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	pass # Replace with function body.
