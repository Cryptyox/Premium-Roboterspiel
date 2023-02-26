extends Node

# this script functions as the "main function" of the game and will be able to show all major
# game elements like the ui and the game itsself

var level_id

var autosaveTimer = 50


onready var game_data = load_json_file("res://savegame.json")
signal game_data_ready(game_data)

func _ready():
	$UI/HomeScreen.show()
	
	print(JSON.print(game_data.get_result()))
	print()
	
	if game_data.result == null:
		# print open popup to tell them their problem
		resetGameData()

	if game_data.result != null:
		emit_signal("game_data_ready", game_data)
	
	#save to json
	game_data.result["player_name"] = "Jack"
	
	#load from json
	var player_name = game_data.result["player_name"]
	
	print(game_data.result["player_name"])
	
	save_json_file("res://savegame.json", game_data)

func _process(delta):
	autosaveTimer -= delta
	if autosaveTimer <= 0:
		autosaveTimer = 50 #sek
		save_json_file("res://savegame.json", game_data)

func resetGameData():
	game_data.result = {
			"player_name": "John",
			"settings": {
				"music_volume": 100,
				"sfx_volume": 100,
				"screen_resolution": 0
			},
			"progress": {
				"level_1": {
					"attempts": 0,
					"time": 0.0,"item_collected": false,
					"finished": false
				},
				"level_2": {
						"attempts": 0,
						"time": 0.0,
						"item_collected": false,
						"finished": false
				},
				"level_3": {
					"attempts": 0,
					"time": 0.0,
					"item_collected": false,
					"finished": false
				},
				"level_4": {
					"attempts": 0,
					"time": 0.0,
					"item_collected": false,
					"finished": false
				}
			}
		}
	save_json_file("res://savegame.json", self.game_data)
	emit_signal("game_data_ready", game_data)


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
	emit_signal("game_data_ready", game_data)
	$UI/SettingsScreen.show()
	
func _on_closeSets(game_data):
	self.game_data = game_data
	save_json_file("res://savegame.json", self.game_data)
	$UI/SettingsScreen.hide()


func _on_openWorld():
	game_data = load_json_file("res://savegame.json")
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


func _on_openPost(attempts, time, object):
	print("main: " + attempts + ", " + time)
	game_data.result["progress"]["level_" + str(level_id + 1)]["attempts"] += attempts
	game_data.result["progress"]["level_" + str(level_id + 1)]["time"] = time
	game_data.result["progress"]["level_" + str(level_id + 1)]["item_collected"] = object
	save_json_file("res://savegame.json", self.game_data)
	$UI/AfterGameScreen.level_id = level_id
	$UI/AfterGameScreen.show()

func _on_closePost():
	$UI/AfterGameScreen.hide()


func load_json_file(path: String) -> JSONParseResult:
	var file = File.new()
	if not file.file_exists(path):
		print("File does not exist:", path)
		return null
	
	file.open(path, File.READ)
	var data_str = file.get_as_text()
	file.close()
	
	return JSON.parse(data_str)

func save_json_file(path: String, data: JSONParseResult) -> bool:
	var file = File.new()
	file.open(path, File.WRITE)
	var json_string = JSON.print(game_data.get_result())
	file.store_string(json_string)
	file.close()
	return file.get_error() == OK
