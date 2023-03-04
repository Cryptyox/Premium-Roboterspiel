extends Spatial

func down():
	$AnimationPlayer.play("down")


func up():
	$AnimationPlayer.play("up")

func timer():
	$Timer.start()

func _on_Timer_timeout():
	up()
