extends Node2D

signal cancel_destination
signal reached_destination
signal facing_new_direction

export var speed = 200 # set by owning component
const ZERO_VECTOR = Vector2(0, 0)

var previously_facing = ""
var previously_pressed_key = false

func _physics_process(delta):
	self._move_to_keyboard()

func _move_to_keyboard():
	var velocity = Vector2(0, 0)
	var new_facing = self.previously_facing
	var pressed_key = false
	
	if Input.is_key_pressed(KEY_RIGHT) or Input.is_key_pressed(KEY_D) or Input.get_action_strength("ui_right") > 0:
		if Input.get_action_strength("ui_right") > 0:
			velocity.x = Input.get_action_strength("ui_right")
		else:
			velocity.x = 1
		new_facing = "Right"
		pressed_key = true
	elif Input.is_key_pressed(KEY_LEFT) or Input.is_key_pressed(KEY_A) or Input.get_action_strength("ui_left") > 0:
		if Input.get_action_strength("ui_left") > 0:
			velocity.x = -Input.get_action_strength("ui_left")
		else:
			velocity.x = -1
		new_facing = "Left"
		pressed_key = true	
	if Input.is_key_pressed(KEY_UP) or Input.is_key_pressed(KEY_W) or Input.get_action_strength("ui_up") > 0:
		if Input.get_action_strength("ui_up") > 0:
			velocity.y = -Input.get_action_strength("ui_up")
		else:
			velocity.y = -1
		new_facing = "Up"
		pressed_key = true
	elif Input.is_key_pressed(KEY_DOWN) or Input.is_key_pressed(KEY_S) or Input.get_action_strength("ui_down") > 0:
		if Input.get_action_strength("ui_down") > 0:
			velocity.y = Input.get_action_strength("ui_down")
		else:
			velocity.y = Input.get_action_strength("ui_down")
		new_facing = "Down"
		pressed_key = true

	if new_facing != self.previously_facing:
		emit_signal("facing_new_direction", new_facing)
		previously_facing = new_facing
	
	if velocity.x != 0 or velocity.y != 0:
		velocity = velocity.normalized() * self.speed
		velocity = self.get_parent().move_and_slide(velocity, ZERO_VECTOR)
		self.emit_signal("cancel_destination") # if clicked, cancel that destination
	else:
		if not pressed_key and previously_pressed_key:
			self.previously_facing = null
			# Not moving and not click-move: stop animation
			self.emit_signal("reached_destination")
	
	self.previously_pressed_key = pressed_key