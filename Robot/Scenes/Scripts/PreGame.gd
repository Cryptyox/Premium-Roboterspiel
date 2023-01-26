extends Popup

var hidden = false

func _process(delta):
	
	if !hidden:
		show()


func _on_Resume_pressed():
	hide()
	hidden = true
