extends Spatial

var respawn_pos
var is_current_checkpoint = false
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	respawn_pos = $Respawnpoint.get_global_transform().origin
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func activate_checkpoint():
	print("Checkpoint set1")
	pass

func _on_Area_body_entered(player):
	if player.has_method("set_checkpoint"):
		if !is_current_checkpoint:
			player.set_checkpoint(respawn_pos, self)
			print("Checkpoint set2")
