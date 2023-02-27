extends Control

signal closePause
signal closeWorld

signal openHome
signal openPause

var text1 = "Tip: Sheep are evil\nanother Tip: A 4-0-0 Alchemist's top crosspath can buff 2 monkeys constantly while a bottom one can buff 3"
var text2 = "Tip: You can trap enderman in a boat so they cannot teleport away\nanother Tip: Try using bounce dribbles instead of flicks, they are less predictable"
var text3 = "Tip: Bogo sort is the most and least efficient sorting algorithm there is\nanother Tip: In the seeds \"dontdigup\" and \"getfixedboi\" you can die by falling up into the sky. Be careful when using your gravity potion when leaving the lab"
var text4 = "Tip: You can fight Emma and Ishin Ashina to confess to the Shura\nanother Tip: When you are in Tangaroa, you can go to the plantation building, find a secret button and go to the 20th floor"
var texts = [text1, text2, text3, text4]

var level_id

onready var world = get_node("../../World")

var game_data = null

signal return_game_data(game_data)


func _on_Root_game_data_ready(game_data):
	self.game_data = game_data
	
	
func set_level(id):
	level_id = id

func _process(delta):
	
	if Input.is_action_pressed("ui_cancel"):
		emit_signal("openPause")
		$PanelContainer/VBoxContainer/MarginContainer/VBoxContainer/MarginContainer/LevelText.set_text(texts[level_id])
		$PanelContainer/VBoxContainer/MarginContainer/VBoxContainer/HBoxContainer2/Label2.set_text(str(get_node("../../World/Robot").tries))
		$PanelContainer/VBoxContainer/MarginContainer/VBoxContainer/HBoxContainer/Label2.set_text("%.2f" % get_node("../../World/Robot").game_timer)
		world.set_is_paused(true)


func _on_HomeButton_pressed():
	var robot = world.get_node("robot")
	
	game_data.result["progress"]["level_" + str(level_id + 1)]["attempts"] =str(int(game_data.result["progress"]["level_" + str(level_id + 1)]["attempts"]) + get_node("../../World/Robot").tries) 
	
	emit_signal("return_game_data", game_data)
	
	emit_signal("closePause")
	emit_signal("closeWorld")
	emit_signal("openHome")
	world.set_is_paused(false)
	
	


func _on_PlayButton_pressed():
	emit_signal("closePause")
	world.set_is_paused(false)


func _on_RestartButton_pressed():
	world.get_node("Robot").die()
	emit_signal("closePause")
	world.set_is_paused(false)



