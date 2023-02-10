extends Control

signal closePre
signal closeWorld

signal openHome

var level_id = 0
var text1 = "Disturbance in the Force you felt? It is not Megatron training backflips. Something terrible must have happened. Find out what it is you must!"
var text2 = "Oh no, the monster is in outrage killing demons in hell hoping that they will drop a voodoo doll of the guide into the lava.\nGo save him!"
var text3 = "The monsters name was leaked. JOHN has not been careful enough when entering the Frozen Computer Lab. But what does he want there? Go get them Tiger!"
var text4 = "This is JOHNs lair. Now he can't go back to his own world anymore so he will have to bring harm to this one. He has built himself a fortress. Not the Flying Fortress of course."
var texts = [text1, text2, text3, text4]

func _draw():
	pass # move cam

func _on_HomeButton_pressed():
	emit_signal("closePre")
	emit_signal("closeWorld")
	emit_signal("openHome")


func _on_PlayButton_pressed():
	emit_signal("closePre", level_id)


func _on_LevelSelectButton_pressed(id):
	$Control/PanelContainer/MarginContainer/Label.set_text(texts[id])
	level_id = id
	# do spawnpoint
