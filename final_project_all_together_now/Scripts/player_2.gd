extends CharacterBody2D

@onready var animated_sprite = $AnimatedSprite2D

@export var speed := 250.0
@export var jump_velocity := -500.0
@export var gravity := 1200.0

var nearby_interactables = []

func _physics_process(delta):

	# ---------------- GRAVITY ----------------
	if not is_on_floor():
		velocity.y += gravity * delta

	# ---------------- INPUT ----------------
	var input_vector = Vector2.ZERO

	if Input.is_action_pressed("p2_right"):
		input_vector.x += 1

	if Input.is_action_pressed("p2_left"):
		input_vector.x -= 1

	input_vector = input_vector.normalized()

	# ---------------- MOVEMENT ----------------
	velocity.x = input_vector.x * speed

	# ---------------- JUMP ----------------
	if Input.is_action_just_pressed("jump"):
		print("p2 jump pressed")

		if is_on_floor():
			velocity.y = jump_velocity
			animated_sprite.play("jump")

	# ---------------- MOVE CHARACTER ----------------
	move_and_slide()

	# ---------------- ANIMATION ----------------
	if not is_on_floor():
		if animated_sprite.animation != "jump":
			animated_sprite.play("jump")

	elif input_vector.length() > 0:
		if animated_sprite.animation != "run":
			animated_sprite.play("run")

	else:
		if animated_sprite.animation != "Idle":
			animated_sprite.play("Idle")

	# ---------------- FLIP ----------------
	if velocity.x < 0:
		animated_sprite.flip_h = true

	elif velocity.x > 0:
		animated_sprite.flip_h = false

	# ---------------- INTERACTION ----------------
	if Input.is_action_just_pressed("p2_interact"):
		if nearby_interactables:
			nearby_interactables.back().interact()


# ---------------- INTERACTION DETECTION ----------------
func _on_interaction_detector_area_entered(area: Area2D) -> void:
	print("interactable detected")
	nearby_interactables.append(area)


func _on_interaction_detector_area_exited(area: Area2D) -> void:
	print("interactable removed")
	nearby_interactables.erase(area)
