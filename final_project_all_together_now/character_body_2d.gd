extends CharacterBody2D

# Get a reference to the AnimatedSprite2D node
@onready var animated_sprite = $AnimatedSprite2D

func _process(delta):
	# Example: Play the "run" animation when moving
	if velocity.length() > 0:
		animated_sprite.play("idle")
	else:
		animated_sprite.play("Run")
		
	# Flip the sprite depending on the direction of movement
	if velocity.x < 0:
		animated_sprite.flip_h = true
	elif velocity.x > 0:
		animated_sprite.flip_h = false
