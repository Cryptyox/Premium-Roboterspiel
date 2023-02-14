extends Control

signal closeSets

# Called when the node enters the scene tree for the first time.
onready var res_menu = $PanelContainer/VBoxContainer/Body/VBoxContainer/HBoxContainer3/Option3/SelectResButton


func _ready():
	add_items()


func add_items():
	res_menu.add_item("1280x720")
	res_menu.add_item("1920x1080")
	res_menu.add_item("2560x1440")
	res_menu.add_item("3840x2160")
	res_menu.add_item("7680x4320")


func _on_SelectResButton_item_selected(index):
	var current_selected_res = index
	if current_selected_res == 0:
		OS.set_window_size(Vector2(1280,720))
	if current_selected_res == 1:
		OS.set_window_size(Vector2(1920,1080))
	if current_selected_res == 2:
		OS.set_window_size(Vector2(2560,1440))
	if current_selected_res == 3:
		OS.set_window_size(Vector2(3840,2160))
	if current_selected_res == 4:
		OS.set_window_size(Vector2(7680,4320))

#func _on_SettingsButton_pressed():
#	if visible == true:
#		hide()
#		get_node("../Buttons/QuitButton").show()
#		pass
#	else:
#		show()
#		get_node("../Buttons/QuitButton").hide()


func _on_HomeButton_pressed():
	emit_signal("closeSets")
