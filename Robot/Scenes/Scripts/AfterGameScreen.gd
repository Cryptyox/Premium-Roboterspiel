extends Control

signal closePost
signal closeWorld

signal open

var level_id = 0
var text1a = ""
var text2a = ""
var text3a = ""
var text4a = ""
var texta = [text1a, text2a, text3a, text4a]
var text1b = ""
var text2b = ""
var text3b = ""
var text4b = ""
var textb = [text1b, text2b, text3b, text4b]

func set_level(id):
	level_id = id


func _draw():
	pass # move cam
	
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
	



