extends WorldEnvironment

var level_id
var temp = 0

signal closeWorld
signal openWorld

func _process(delta):
	#if temp != level_id:
	environment = load(str("res://assets/Environments/", str(level_id) , ".tres"))
		#emit_signal("closeWorld")
		#emit_signal("openWorld")
	temp = level_id
	
	
