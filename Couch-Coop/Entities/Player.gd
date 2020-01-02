tool
extends KinematicBody2D

const MOVE_SPEED = 200
const ROTATION_VELOCITY = 360
const TURBO_MULTIPLIER = 2

const UP_BUTTON_ID = 12
const DOWN_BUTTON_ID = UP_BUTTON_ID + 1
const LEFT_BUTTON_ID = DOWN_BUTTON_ID + 1
const RIGHT_BUTTON_ID = LEFT_BUTTON_ID + 1
const TURBO_BUTTON_ID = 2

export var joypad_id = 0
export var tint:Color setget set_tint, get_tint

var _velocity:Vector2 = Vector2.ZERO
var _tint:Color
var _turbo:bool = false

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
	
	if _turbo:
		rotation *= TURBO_MULTIPLIER
	
	self.rotation_degrees += rotation
	
	self.move_and_slide(_velocity * MOVE_SPEED)
	
func stop():
	self._velocity = Vector2.ZERO

func process_joypad(event, is_pressed):
		_velocity = Vector2(0, 0)
		var button = event as InputEventJoypadButton
		
		if is_pressed:
			if button.button_index == TURBO_BUTTON_ID:
				_turbo = true
				
			if button.button_index == UP_BUTTON_ID:
				_velocity.y = -1
			elif button.button_index == DOWN_BUTTON_ID:
				_velocity.y = 1
				
			if button.button_index == LEFT_BUTTON_ID:
				_velocity.x = -1
			elif button.button_index == RIGHT_BUTTON_ID:
				_velocity.x = 1
		else:
			if button.button_index == TURBO_BUTTON_ID:
				_turbo = false
			elif button.button_index == UP_BUTTON_ID or button.button_index == DOWN_BUTTON_ID:
				_velocity.y = 0
			elif button.button_index == LEFT_BUTTON_ID or button.button_index == RIGHT_BUTTON_ID:
				_velocity.x = 0
		