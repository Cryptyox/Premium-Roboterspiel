extends Popup


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	if Input.is_action_pressed("ui_cancel"):
		
		show()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Resume_pressed():
	hide()
	pass # Replace with function body.


func _on_RestartButton_pressed():
	hide()
	pass # Replace with function body.
