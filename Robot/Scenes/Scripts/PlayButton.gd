extends TextureButton



#Function loads wanted Scene (Main Game Scene)
func _pressed() -> void:
	get_tree().change_scene("res://Scenes/World.tscn")

