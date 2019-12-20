extends Area2D

func _on_Block_body_entered(body):
	get_parent().remove_child(self)
	Globals.collected_heart()

func _process(delta):
	$Sprite.rotation_degrees += 2