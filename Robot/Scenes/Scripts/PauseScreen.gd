extends Control

func _process(delta):
	
	if Input.is_action_pressed("ui_cancel"):
		$Popup.show()

