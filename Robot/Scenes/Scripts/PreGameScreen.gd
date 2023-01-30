extends Control

func _ready():
	$Popup.show()


func _on_SelectChapter_pressed(spawn):
	var robot = get_node("../../ContainsWorld/Robot")
	robot.translation = spawn
	


func _on_HomeButton_pressed():
	get_tree().change_scene("res://Scenes/1_TestUI.tscn")


func _on_PlayButton_pressed():
	$Popup.hide()
