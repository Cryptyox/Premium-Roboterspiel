extends Popup


func _process(delta):
	
	if Input.is_action_pressed("ui_cancel"):
		show()


func _on_Resume_pressed():
	hide()


func _on_RestartButton_pressed():
	hide()
