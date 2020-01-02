extends Node2D

func _unhandled_input(event):
	if event is InputEventJoypadButton:
		var button = event as InputEventJoypadButton
		print("Controller " + str(button.device) + " pressed " + str(button.button_index))