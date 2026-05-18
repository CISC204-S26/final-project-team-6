extends Sprite2D

@export var speed = 250
@export var min_x = 150
@export var max_x = 1000
@export var min_y = 100
@export var max_y = 550
var health = 3

var move_direction = Vector2.ZERO

func _ready():
	randomize()
	pick_new_direction()
	$Timer.start()

func _process(delta):
	position += move_direction * speed * delta

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


func take_damage(amount: int) -> void:
	health -= amount
	print("Enemy hit! Health remaining: ", health)
	if health <= 0:
		die()

func die() -> void:
	print("Enemy defeated!")
	queue_free()

func interact() -> void:
	print("No interaction")
