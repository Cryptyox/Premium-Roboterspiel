extends Spatial

signal openPost(attempts, time, object)

func end_game(attempts, time, object):
	# save time in file
	# save attempts in file
	print("endpoint: " + attempts + ", " + time)
	emit_signal("openPost", attempts, time, object)
	print("coision2")
	# öffne postGameScreen
	# 
