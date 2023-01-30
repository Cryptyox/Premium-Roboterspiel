extends Control

func _on_HomeButton_pressed():
	get_tree().change_scene("res://Scenes/1_TestUI.tscn")


func _on_RestartButton_pressed():
	var robot = get_node("../../ContainsWorld/Robot")
	var spawn = robot.get_spawn()
	robot.translation = spawn
	$Popup.hide()


func _on_LevelSelectButton_pressed():
	$Popup.hide()
	get_node("../PreGameScreen/Popup").show()
	
