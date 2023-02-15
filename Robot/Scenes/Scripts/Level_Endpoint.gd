extends Spatial

signal openPost

func end_game():
	pass
	# save time in file
	# save attempts in file
	emit_signal("openPost")
	# öffne postGameScreen
	# 
