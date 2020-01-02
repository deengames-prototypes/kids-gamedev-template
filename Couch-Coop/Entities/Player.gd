extends KinematicBody2D

const MOVE_SPEED = 200
const ROTATION_VELOCITY = 360
const TURBO_MULTIPLIER = 2
const MAX_TURBO_SECONDS = 5
# 2 => recharges 2x as fast as it dispenses
const TURBO_RECHARGE_MULTIPLIER = 2

const UP_BUTTON_ID = 12
const DOWN_BUTTON_ID = UP_BUTTON_ID + 1
const LEFT_BUTTON_ID = DOWN_BUTTON_ID + 1
const RIGHT_BUTTON_ID = LEFT_BUTTON_ID + 1
const TURBO_BUTTON_ID = 2

export var joypad_id = 0
export var sprite:Texture
export var tint:Color setget set_tint, get_tint

var _velocity:Vector2 = Vector2.ZERO
var _tint:Color
var _turbo:bool = false
var _turbo_left = MAX_TURBO_SECONDS

func set_tint(value):
	if value != null and $Sprite != null:
		_tint = value
		$Sprite.modulate = _tint

func get_tint():
	return _tint
	
func _ready():
	$CollisionShape2D.visible = true
	$TurboBar.max_value = MAX_TURBO_SECONDS
	$Sprite.texture = sprite

func _process(delta):
	var rotation = (ROTATION_VELOCITY * delta)
	
	if _turbo:
		if _turbo_left > 0:
			rotation *= TURBO_MULTIPLIER
			_velocity *= 2
			_turbo_left -= delta # 1 per second
		elif _turbo_left <= 0:
			_turbo = false
	else:
		_turbo_left += TURBO_RECHARGE_MULTIPLIER * delta
		_turbo_left = min(_turbo_left, MAX_TURBO_SECONDS)
	
	$Sprite.rotation_degrees += rotation
	self.move_and_slide(_velocity * MOVE_SPEED)
	$TurboBar.value = _turbo_left
	
func stop():
	self._velocity = Vector2.ZERO

func process_joypad(event, is_pressed):
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
		