extends Node

# this script functions as the "main function" of the game and will be able to show all major
# game elements like the ui and the game itsself

var level_id
onready var data = load_from_json("res://savegame.json")

func _ready():
	$UI/HomeScreen.show()
	

# create event handler with events such as
# open settings
# open world
# open menus over the world
# close menus

# events handled with signals

# each scene has to have a signal that
# closes itsself
# opens every other scene that it can open

# eg  home can close itsself and open wolrd+preGame and settings

func _on_openHome():
	$UI/HomeScreen.show()

func _on_closeHome():
	$UI/HomeScreen.hide()


func _on_openSets():
	$UI/SettingsScreen.show()
	
func _on_closeSets():
	$UI/SettingsScreen.hide()


func _on_openWorld():
	$World.show()
	
func _on_closeWorld():
	$World.hide()


func _on_openPre():
	$UI/PreGameScreen.show()

func _on_closePre():
	# this signal gets the level id of chosen level
	level_id = $UI/PreGameScreen.level_id
	$UI/PreGameScreen.hide()


func _on_openPause():
	$UI/PauseScreen.level_id = level_id
	$UI/PauseScreen.show()
	
func _on_closePause():
	$UI/PauseScreen.hide()


func _on_openPost():
	$UI/AfterGameScreen.level_id = level_id
	$UI/AfterGameScreen.show()

func _on_closePost():
	$UI/AfterGameScreen.hide()


func save_to_json(filename: String, data: Dictionary) -> void:
	var file = File.new()
	file.open(filename, File.WRITE)
	file.store_line(JSON.print(data))
	file.close()

func load_from_json(filename: String) -> Dictionary:
	var file = File.new()
	var data = {}
	if file.file_exists(filename):
		print("JSON loaded")
		file.open(filename, File.READ)
		data = JSON.parse(file.get_as_text())
		file.close()
	return data
