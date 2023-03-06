extends WorldEnvironment

var level_id
var temp = 0

signal closeWorld
signal openWorld

#onready var music = AudioStreamPlayer.new()

func _process(delta):
	#if temp != level_id:
		#music.stream = load("res://Resources/Music/" + str(level_id) + ".mp3")
		#music.play()
	environment = load(str("res://assets/Environments/", str(level_id) , ".tres"))
		
	temp = level_id
	
	
	
