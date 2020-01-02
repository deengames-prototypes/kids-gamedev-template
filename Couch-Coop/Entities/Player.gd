tool
extends KinematicBody2D

const ROTATION_VELOCITY = 360
const TURBO_MULTIPLIER = 2

export var joypad_id = 0
export var tint:Color setget set_tint, get_tint

var _tint:Color

func set_tint(value):
	if value != null and $Sprite != null:
		_tint = value
		$Sprite.modulate = _tint

func get_tint():
	return _tint
	
func _ready():
	$CollisionShape2D.visible = true

func _process(delta):
	var rotation = (ROTATION_VELOCITY * delta)
	
	if Input.is_action_pressed("joypad_snes_y"):
		rotation *= TURBO_MULTIPLIER
	
	self.rotation_degrees += rotation
	