extends CharacterBody2D

@onready var animated_sprite = $AnimatedSprite2D

@export var speed := 250.0

var shuriken = preload("res://Scenes/Shuriken.tscn")

var nearby_interactables = []
var facing = Vector2(1,0)

func _physics_process(delta):

	# ---------------- INPUT ----------------
	var input_vector = Vector2.ZERO

	if Input.is_action_pressed("p2_right"):
		input_vector.x += 1
	if Input.is_action_pressed("p2_left"):
		input_vector.x -= 1
	if Input.is_action_pressed("p2_down"):
		input_vector.y += 1
	if Input.is_action_pressed("p2_up"):
		input_vector.y -= 1

	input_vector = input_vector.normalized()

	# ---------------- MOVEMENT ----------------
	velocity = input_vector * speed
	move_and_slide()
	if input_vector.length() > 0:
		facing = input_vector.normalized()
	
	#Shuriken
	if Input.is_action_just_pressed("Shuriken"):
		shoot_shuriken(facing)

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


# -----------------------WEAPON USUAGE(WIP)------------------------
func shoot_shuriken(dir: Vector2):
	var newshuriken = shuriken.instantiate()
	newshuriken.direction = dir
	newshuriken.position = position
	add_sibling(newshuriken)
	
	pass
