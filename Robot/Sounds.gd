extends Spatial

func _ready():
	var player = AudioStreamPlayer.new()
	self.add_child(player)
	player.stream = load("res://Jumpsound.wav")
	player.play()
