extends Control

signal closePre
signal closeWorld

signal openHome

func _draw():
	pass # move cam
	
func _on_SelectChapter_pressed(spawn):
	var robot = get_node("../../ContainsWorld/Robot")
	robot.translation = spawn
	robot.set_spawn(spawn)


func _on_HomeButton_pressed():
	emit_signal("closePre")
	emit_signal("closeWorld")
	emit_signal("openHome")


func _on_PlayButton_pressed():
	emit_signal("closePre")



