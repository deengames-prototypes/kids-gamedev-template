extends Node

var stars_collected = 0
var star_label

func collected_heart():
	stars_collected += 1
	star_label.text = "x" + str(stars_collected)