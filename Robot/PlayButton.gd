extends TextureButton


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
#func _ready():
	

#Funktion lädt bei Knopfdurck Hauptscene
func _button_pressed():
	get_tree().change_scene("res://Robot.tscn")
