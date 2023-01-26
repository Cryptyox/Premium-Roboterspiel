extends TextureButton

func _pressed() -> void:
	get_tree().change_scene("res://Scenes/Startbildschirm.tscn")
