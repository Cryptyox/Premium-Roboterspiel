extends Control

signal closePause
signal closeWorld

signal openHome
signal openPause

func _process(delta):
	
	if Input.is_action_pressed("ui_cancel"):
		emit_signal("openPause")
		#pause gameplay



func _on_HomeButton_pressed():
	emit_signal("closePause")
	emit_signal("closeWorld")
	emit_signal("openHome")


func _on_PlayButton_pressed():
	emit_signal("closePause")
	#resume gameplay


func _on_RestartButton_pressed():
	#var robot = get_node("../../ContainsWorld/Robot")
	#var spawn = robot.get_spawn()
	#robot.translation = spawn
	#$Popup.hide()
	emit_signal("closePause")
	#resume gameplay
