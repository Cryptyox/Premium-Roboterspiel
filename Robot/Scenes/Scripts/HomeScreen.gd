extends Control

func _on_ExitButton_pressed():
	get_tree().quit()


func _on_SettingsButton_pressed():
	get_node("../SettingsScreen/SettingsPopup").show()


func _on_PlayButton_pressed():
	get_tree().change_scene("res://Scenes/UI_World.tscn")


func _on_CheeseButton_pressed():
	$CheeseSoundEffect.play()
