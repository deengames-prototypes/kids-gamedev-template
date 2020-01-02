extends KinematicBody2D

const ROTATION_VELOCITY = 360
const TURBO_MULTIPLIER = 2

func _process(delta):
	var rotation = (ROTATION_VELOCITY * delta)
	
	if Input.is_action_pressed("joypad_snes_y"):
		rotation *= TURBO_MULTIPLIER
	
	self.rotation_degrees += rotation
	