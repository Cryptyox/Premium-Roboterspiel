extends TextureButton



#Function loads wanted Scene (Main Game Scene)
func _pressed() -> void:
	get_tree().change_scene("res://World.tscn")

# Called when the node enters the scene tree for the first time.
#func _ready():
func _ready() -> void:
	print("Buttonready")

