extends Control

signal closeHome

signal openWorld
signal openPre
signal openSets

#func _process(delta):
	
	#if Input.is_action_pressed("ui_cancel"):
	#	emit_signal("openSets")
	
	

func _on_ExitButton_pressed():
	$ExitDialog.show()


func _on_SettingsButton_pressed():
	emit_signal("openSets")


func _on_PlayButton_pressed():
	#get_tree().change_scene("res://Scenes/UI_World.tscn")
	emit_signal("closeHome")
	emit_signal("openWorld")
	emit_signal("openPre")
	
	


func _on_CheeseButton_pressed():
	#$CheeseSoundEffect.play()
	pass

func _on_Cancel_pressed():
	$ExitDialog.hide()


func _on_Confirm_pressed():
	get_tree().quit()
