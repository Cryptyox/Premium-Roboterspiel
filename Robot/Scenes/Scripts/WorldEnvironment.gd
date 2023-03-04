extends WorldEnvironment

var level_id

func _process(delta):
	environment.sky.panorama = load("res://assets/bg" + str(level_id) + ".png")
