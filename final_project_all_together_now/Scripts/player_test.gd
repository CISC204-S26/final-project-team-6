extends CharacterBody2D

const SPEED = 300.0

var nearby_interactables = []

func _physics_process(delta: float) -> void:
	var input_vector = Vector2.ZERO
		
	#Gets input directions
	input_vector.x = Input.get_axis("move_left", "move_right")
	input_vector.y = Input.get_axis("move_up", "move_down")
	
	#Ensures moving diagonal isn't faster than normal speed
	input_vector = input_vector.normalized()
	
	if Input.is_action_just_pressed("p1_interact"):
		if nearby_interactables:
			nearby_interactables.back().interact()
	
	velocity = input_vector * SPEED
	
	move_and_slide()


func _on_interaction_detector_area_entered(area: Area2D) -> void:
	print("interactable detected")
	#area.set_active(true)
	nearby_interactables.append(area)


func _on_interaction_detector_area_exited(area: Area2D) -> void:
	print("interactable removed")
	#area.set_active(false)
	nearby_interactables.erase(area)
