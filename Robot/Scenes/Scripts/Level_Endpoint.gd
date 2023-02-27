extends Spatial

signal openPost

func end_game(attempts, time, item_collected):
	
	emit_signal("openPost")
