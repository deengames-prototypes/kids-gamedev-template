extends KinematicBody2D

const ROTATION_VELOCITY = 720

func _process(delta):
	self.rotation_degrees += (ROTATION_VELOCITY * delta)
