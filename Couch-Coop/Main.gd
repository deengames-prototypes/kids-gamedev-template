extends Node2D

var _current_event:InputEventJoypadButton
var _current_events = []
var _player_joypad_map = {}

func _ready():
	var children = self.get_children()
	for child in children:
		if "Player" in child.name:
			_player_joypad_map[child.joypad_id] = child

func _unhandled_input(event):
	if event == null or event.device == null:
		return
		
	if event is InputEventJoypadButton:
		if event.is_pressed():
			#_current_event = event
			_current_events.append(event)
		#elif _current_event != null:
		elif len(_current_events) > 0:
			var joypad_id = _current_event.device
			_player_joypad_map[joypad_id].process_joypad(_current_event, false)
			_current_event = null # released
			
func _process(delta):
	if _current_event != null:
		var joypad_id = _current_event.device
		if joypad_id in _player_joypad_map:
			_player_joypad_map[joypad_id].process_joypad(_current_event, true)