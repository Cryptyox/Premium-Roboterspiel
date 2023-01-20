extends VideoPlayer




# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
# Checks if video is playing if not, Loops it
func _process(delta):
	if is_playing() == true:
		pass
	else:
		play()





func _on_Settings_popup_hide():
	stop()
	play()
