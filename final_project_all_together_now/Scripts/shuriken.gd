extends Node2D
@export var direction = Vector2(0,0)

# Called when the node enters the scene tree for the first time.
func _ready():
	if direction == Vector2 (0,0):
		direction = Vector2(10,0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position += direction
	pass
