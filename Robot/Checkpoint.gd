extends Spatial

var respawn_pos
var is_current_checkpoint = false

# Called when the node enters the scene tree for the first time.
func _ready():
	respawn_pos = $Respawnpoint.get_global_transform().origin
	
func is_active():
	return is_current_checkpoint

func get_pos():
	return global_transform.origin

func activate_checkpoint():
	print(name + " active")
	print(global_transform.origin, translation, $Respawnpoint.get_global_transform().origin, respawn_pos)
	is_current_checkpoint = true
	return respawn_pos

func deactivate_checkpoint():
	print(name + " disabled")
	is_current_checkpoint = true
