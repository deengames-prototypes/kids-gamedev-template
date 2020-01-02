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
			_current_events.append(event)
		else:
			var joypad_id = event.device
			for i in range(len(_current_events)):
				var e = _current_events[i]
				if e.device == event.device and e.button_index == event.button_index:
					_player_joypad_map[joypad_id].process_joypad(event, false)
					_current_events.remove(i)
					break
			
func _process(delta):
	for event in _current_events:
		var joypad_id = event.device
		if joypad_id in _player_joypad_map:
			_player_joypad_map[joypad_id].process_joypad(event, true)