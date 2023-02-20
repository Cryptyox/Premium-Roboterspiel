extends Spatial

func _ready():
	var player = AudioStreamPlayer.new()
	self.add_child(player)
	player.stream = load("res://Jumpsound2.wav")
	player.play()
