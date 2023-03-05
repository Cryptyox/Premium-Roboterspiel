extends Control

signal closePre
signal closeWorld

signal openHome

signal chooseLevel(id)

var level_id = 0
var text1 = "Disturbance in the Force you felt? It is not Megatron training backflips. Something terrible must have happened. Find out what it is you must!"
var text2 = "Oh no, the monster is in outrage killing demons in hell hoping that they will drop a voodoo doll of the guide into the lava.\nGo save him!"
var text3 = "The monsters name was leaked. JOHN has not been careful enough when entering the Frozen Computer Lab. But what does he want there? Go get them Tiger!"
var text4 = "This is JOHNs lair. Now he can't go back to his own world anymore so he will have to bring harm to this one. He has built himself a fortress. Not the Flying Fortress of course."
var texts = [text1, text2, text3, text4]

var fall_timer = 0
var changed = false

onready var world = get_node("../../World")
onready var robot = world.get_node("Robot")

onready var level1Attempts = $MarginContainer/PanelContainer/VBoxContainer/Level1/LevelSelectButton/ButtonText/MarginContainer/VBoxContainer/HBoxContainer/HBoxContainer/Label2
onready var level1Time = $MarginContainer/PanelContainer/VBoxContainer/Level1/LevelSelectButton/ButtonText/MarginContainer/VBoxContainer/HBoxContainer/HBoxContainer2/Label4
onready var level1Stars = $MarginContainer/PanelContainer/VBoxContainer/Level1/LevelSelectButton/ButtonText/MarginContainer/VBoxContainer/HBoxContainer/MarginContainer/TextureProgress

onready var button2 = $MarginContainer/PanelContainer/VBoxContainer/Level2/LevelSelectButton
onready var level2Attempts = $MarginContainer/PanelContainer/VBoxContainer/Level2/LevelSelectButton/Buttontext/MarginContainer/VBoxContainer/HBoxContainer/HBoxContainer/Label2
onready var level2Time = $MarginContainer/PanelContainer/VBoxContainer/Level2/LevelSelectButton/Buttontext/MarginContainer/VBoxContainer/HBoxContainer/HBoxContainer2/Label4
onready var level2Stars = $MarginContainer/PanelContainer/VBoxContainer/Level2/LevelSelectButton/Buttontext/MarginContainer/VBoxContainer/HBoxContainer/MarginContainer/TextureProgress

onready var button3 = $MarginContainer/PanelContainer/VBoxContainer/Level3/LevelSelectButton
onready var level3Attempts = $MarginContainer/PanelContainer/VBoxContainer/Level3/LevelSelectButton/ButtonText/MarginContainer/VBoxContainer/HBoxContainer/HBoxContainer/Label2
onready var level3Time = $MarginContainer/PanelContainer/VBoxContainer/Level3/LevelSelectButton/ButtonText/MarginContainer/VBoxContainer/HBoxContainer/HBoxContainer2/Label4
onready var level3Stars = $MarginContainer/PanelContainer/VBoxContainer/Level3/LevelSelectButton/ButtonText/MarginContainer/VBoxContainer/HBoxContainer/MarginContainer/TextureProgress

onready var button4 = $MarginContainer/PanelContainer/VBoxContainer/Level4/LevelSelectButton
onready var level4Attempts = $MarginContainer/PanelContainer/VBoxContainer/Level4/LevelSelectButton/ButtonText/MarginContainer/VBoxContainer/HBoxContainer/HBoxContainer/Label2
onready var level4Time = $MarginContainer/PanelContainer/VBoxContainer/Level4/LevelSelectButton/ButtonText/MarginContainer/VBoxContainer/HBoxContainer/HBoxContainer2/Label4
onready var level4Stars = $MarginContainer/PanelContainer/VBoxContainer/Level4/LevelSelectButton/ButtonText/MarginContainer/VBoxContainer/HBoxContainer/MarginContainer/TextureProgress

var game_data = null

func _on_Root_game_data_ready(game_data_new):
	game_data = game_data_new
	prepare_values()

func prepare_values():
	
	level1Attempts.text = str(game_data.result["progress"]["level_1"]["attempts"])
	level1Time.text = str(game_data.result["progress"]["level_1"]["time"])
	var stars1 = 0
	if game_data.result["progress"]["level_1"]["finished"]:
		stars1 += 1
	if int(game_data.result["progress"]["level_1"]["time"]) < 60 && int(game_data.result["progress"]["level_1"]["time"]) != 0:
		stars1 += 1
	if game_data.result["progress"]["level_1"]["item_collected"]:
		stars1 += 1
	level1Stars.value = stars1
	
	level2Attempts.text = str(game_data.result["progress"]["level_2"]["attempts"])
	level2Time.text = str(game_data.result["progress"]["level_2"]["time"])
	var stars2 = 0
	if game_data.result["progress"]["level_2"]["finished"]:
		stars2 += 1
	if int(game_data.result["progress"]["level_2"]["time"]) < 60 && int(game_data.result["progress"]["level_2"]["time"]) != 0:
		stars2 += 1
	if game_data.result["progress"]["level_2"]["item_collected"]:
		stars2 += 1
	level2Stars.value = stars2
	#if !game_data.result["progress"]["level_1"]["finished"]:
	#	button2.hide()
	
	level3Attempts.text = str(game_data.result["progress"]["level_3"]["attempts"])
	level3Time.text = str(game_data.result["progress"]["level_3"]["time"])
	var stars3 = 0
	if game_data.result["progress"]["level_3"]["finished"]:
		stars3 += 1
	if int(game_data.result["progress"]["level_3"]["time"]) < 80 && int(game_data.result["progress"]["level_3"]["time"]) != 0:
		stars3 += 1
	if game_data.result["progress"]["level_3"]["item_collected"]:
		stars3 += 1
	level3Stars.value = stars3
	#if !game_data.result["progress"]["level_2"]["finished"]:
	#	button3.hide()
	
	level4Attempts.text = str(game_data.result["progress"]["level_4"]["attempts"])
	level4Time.text = str(game_data.result["progress"]["level_4"]["time"])
	var stars4 = 0
	if game_data.result["progress"]["level_4"]["finished"]:
		stars4 += 1
	if int(game_data.result["progress"]["level_4"]["time"]) < 0 && int(game_data.result["progress"]["level_4"]["time"]) != 0:
		stars4 += 1
	if game_data.result["progress"]["level_4"]["item_collected"]:
		stars4 += 1
	level4Stars.value = stars4
	#if !game_data.result["progress"]["level_3"]["finished"]:
	#	button4.hide()
	

func _draw():
	
	robot.do_cam(false)
	
	$MarginContainer/PanelContainer/VBoxContainer/Level1/LevelSelectButton.pressed = true
	_on_LevelSelectButton_pressed(0)


func _process(delta):
	if changed:
		if fall_timer > 0:
			fall_timer -= delta
			world.get_tree().get_root().set_disable_input(true)
		if fall_timer <= 0:
			changed = false
			world.set_is_paused(true)
			world.get_tree().get_root().set_disable_input(false)


func _on_HomeButton_pressed():
	emit_signal("closePre")
	emit_signal("closeWorld")
	emit_signal("openHome")
	robot.do_cam(true)
	
	world.set_is_paused(false)


func _on_PlayButton_pressed():
	emit_signal("closePre")
	robot.do_cam(true)
	world.set_is_paused(false)
	


func _on_LevelSelectButton_pressed(id):
	$Control/PanelContainer/MarginContainer/Label.set_text(texts[id])
	
	var old_level = world.get_node("containsLevel" + str(level_id+1))
	old_level.hide()
	old_level.transform.origin = Vector3(0,0,-5)
	
	var new_level = world.get_node("containsLevel" + str(id+1))
	new_level.show()
	new_level.transform.origin = Vector3(0,0,5)
	
	level_id = id
	emit_signal("chooseLevel", id)
	changed = true
	
	fall_timer = .5
	
	world.set_is_paused(false)
	
	
	get_node("../../World/WorldEnvironment").level_id = level_id
	



