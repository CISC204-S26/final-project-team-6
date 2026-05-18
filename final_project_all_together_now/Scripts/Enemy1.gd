extends Sprite2D

var leftBound = 150.0
var rightBound = 1000.0
var topBound = 100.0
var bottomBound = 550.0
var movementSpeed = 300.0
var health = 3

var targetPosition: Vector2
var movingRight: bool = false

func _ready() -> void:
	position = Vector2(rightBound, randf_range(topBound, bottomBound))
	pickNextTarget()


func _process(delta):
	var direction = (targetPosition - position).normalized()
	position += direction * movementSpeed * delta
	
	if position.distance_to(targetPosition)< 5.0:
		pickNextTarget()

func pickNextTarget() -> void:
	if movingRight:
		targetPosition = Vector2(rightBound, randf_range(topBound, bottomBound))
	else:
		targetPosition = Vector2(leftBound, randf_range(topBound, bottomBound))
	movingRight = !movingRight

func take_damage(amount: int) -> void:
	health -= amount
	print("Enemy hit! Health remaining: ", health)
	if health <= 0:
		die()

func die() -> void:
	print("Enemy defeated!")
	queue_free()
