extends Control

signal closeSets(game_data)

# Called when the node enters the scene tree for the first time.
onready var name_lineEdit = $PanelContainer/VBoxContainer/Body/VBoxContainer/containsRenamePlayer/LineEdit
onready var res_menu = $PanelContainer/VBoxContainer/Body/VBoxContainer/HBoxContainer3/Option3/SelectResButton
onready var music_sider = $PanelContainer/VBoxContainer/Body/VBoxContainer/HBoxContainer/Option1/VolumeSlider
onready var sfx_slider = $PanelContainer/VBoxContainer/Body/VBoxContainer/HBoxContainer2/Option2/EffectSlider
onready var reset_button = $PanelContainer/VBoxContainer/Body/VBoxContainer/containsResetSavegame/Button5

var game_data = null

func _on_Root_game_data_ready(game_data):
	self.game_data = game_data
	prepare_values()

func prepare_values():
	name_lineEdit.text = game_data.result["player_name"]
	
	res_menu.add_item("Fullscreen")
	res_menu.add_item("1280x720")
	res_menu.add_item("1920x1080")
	res_menu.add_item("2560x1440")
	res_menu.add_item("3840x2160")
	res_menu.add_item("7680x4320")
	res_menu.selected = game_data.result["settings"]["screen_resolution"]
	
	music_sider.value = game_data.result["settings"]["music_volume"]
	sfx_slider.value = game_data.result["settings"]["sfx_volume"]


#func _on_SelectResButton_item_selected(index):
#	var current_selected_res = index
#	if current_selected_res == 0:
#		OS.set_window_size(Vector2(1280,720))
#	if current_selected_res == 1:
#		OS.set_window_size(Vector2(1920,1080))
#	if current_selected_res == 2:
#		OS.set_window_size(Vector2(2560,1440))
#	if current_selected_res == 3:
#		OS.set_window_size(Vector2(3840,2160))
#	if current_selected_res == 4:
#		OS.set_window_size(Vector2(7680,4320))


func _on_HomeButton_pressed():
	game_data.result["player_name"] = name_lineEdit.text
	game_data.result["settings"]["screen_resolution"] = res_menu.selected
	game_data.result["settings"]["music_volume"] = music_sider.value
	game_data.result["settings"]["sfx_volume"] = sfx_slider.value
	emit_signal("closeSets", game_data)


func _on_Button5_pressed():
	get_node("../../").resetGameData()





