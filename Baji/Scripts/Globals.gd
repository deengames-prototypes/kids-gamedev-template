extends Node

var hearts_collected = 0
var heart_label

func collected_heart():
	hearts_collected += 1
	heart_label.text = "x" + str(hearts_collected)