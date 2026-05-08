extends CharacterBody2D

@onready var animated_sprite = $AnimatedSprite2D

@export var speed := 200.0

func _physics_process(delta):

	# ---------------- INPUT ----------------
	var input_vector = Vector2.ZERO

	if Input.is_action_pressed("move_right"):
		input_vector.x += 1
	if Input.is_action_pressed("move_left"):
		input_vector.x -= 1
	if Input.is_action_pressed("move_down"):
		input_vector.y += 1
	if Input.is_action_pressed("move_up"):
		input_vector.y -= 1

	input_vector = input_vector.normalized()

	# ---------------- MOVEMENT ----------------
	velocity = input_vector * speed
	move_and_slide()

	# ---------------- ANIMATION ----------------
	if input_vector.length() > 0:
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
