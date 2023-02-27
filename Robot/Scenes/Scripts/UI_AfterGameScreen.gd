extends Control

signal closePost
signal closeWorld

signal openPre
signal openHome

var level_id = 0
var text1a = "You have found yourself some pretty useful gear. Now you will be able to jump twice."
var text2a = "Now the monster cannot summon any other evil creatures. The cultists are sad now, but who cares. Hopefully Bwoser won't mind."
var text3a = "You have succesfully sorted this worlds list with normal Bogo sortand programmed a stable Qantum Bogo sort."
var text4a = "JOHN has been sent to the Duat and is now guarded by the egyptians gods. He will harm nobody in near future."
var texta = [text1a, text2a, text3a, text4a]
var text1b = "But you'll have to hurry, There is news. The monster has awakened and is threatening to get out of Hell and destroy our world"
var text2b = "But there is still Princess Banana to save.\nOff you go HERO!"
var text3b = "But you still have to save Princess Banana"
var text4b = ""
var textb = [text1b, text2b, text3b, text4b]

#var time = 0
#var attempts = 0

onready var world = get_node("../../World")
onready var robot = world.get_node("Robot")


func _on_Root_game_data_ready(game_data):
	pass # Replace with function body.
	


func set_level(id):
	level_id = id


func _draw():
	$PanelContainer/VBoxContainer/MarginContainer/VBoxContainer/MarginContainer/LevelText.set_text(texta[level_id])
	$PanelContainer/VBoxContainer/MarginContainer/VBoxContainer/MarginContainer2/LevelText.set_text(textb[level_id])
	robot.do_cam(false)
	world.set_is_paused(true)
	
func _on_HomeButton_pressed():
	emit_signal("closePost")
	emit_signal("closeWorld")
	emit_signal("openHome")
	robot.do_cam(true)
	world.set_is_paused(false)


	
	
func _on_RestartButton_pressed():
	emit_signal("closePost")
	robot.spawn()
	robot.do_cam(true)
	world.set_is_paused(false)


func _on_LevelSelectButton_pressed():
	emit_signal("closePost")
	emit_signal("openPre")
	robot.do_cam(true)
	world.set_is_paused(false)
	






