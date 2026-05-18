extends CharacterBody2D

@export var speed = 150
@export var min_x = 0
@export var max_x = 800
@export var min_y = 0
@export var max_y = 600

var move_direction = Vector2.ZERO

func _ready():
	randomize()
	pick_new_direction()
	$Timer.start()

func _physics_process(delta):

	velocity = move_direction * speed
	position += velocity * delta

	# Keep enemy inside area
	position.x = clamp(position.x, min_x, max_x)
	position.y = clamp(position.y, min_y, max_y)

func pick_new_direction():

	var directions = [
		Vector2.UP,
		Vector2.DOWN,
		Vector2.LEFT,
		Vector2.RIGHT,
		Vector2(1,1).normalized(),
		Vector2(-1,1).normalized(),
		Vector2(1,-1).normalized(),
		Vector2(-1,-1).normalized()
	]

	move_direction = directions[randi() % directions.size()]

func _on_timer_timeout():
	pick_new_direction()
