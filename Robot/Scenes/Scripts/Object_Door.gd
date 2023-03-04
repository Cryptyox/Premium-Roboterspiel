extends Spatial

func down():
	$AnimationPlayer.play("down")


func up():
	$AnimationPlayer.play("up")

func timer():
	$Timer.start()

func _on_Timer_timeout():
	up()
	$Timer.stop()


func _on_PressurePlate_openDoor():
	$Timer.stop()
	if $StaticBody.scale.y == 1.5:
		down()
	


func _on_PressurePlate_startTimer():
	timer()
