extends Control

func _process(delta):
	
	if Input.is_action_pressed("ui_cancel"):
		$Popup.show()
		#pause gameplay



func _on_HomeButton_pressed():
	get_tree().change_scene("res://Scenes/1_TestUI.tscn")


func _on_PlayButton_pressed():
	$Popup.hide()
	#resume gameplay


func _on_RestartButton_pressed():
	var robot = get_node("../../ContainsWorld/Robot")
	var spawn = robot.get_spawn()
	robot.translation = spawn
	$Popup.hide()
