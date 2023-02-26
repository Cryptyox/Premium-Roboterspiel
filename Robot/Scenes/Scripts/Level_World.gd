extends Spatial

var is_paused = false setget set_is_paused

func set_is_paused(value):
	is_paused = value
	get_tree().paused = is_paused

func _ready():
	_on_PreGameScreen_chooseLevel(0)
	
# lvl 0 - 3
func _on_PreGameScreen_chooseLevel(id):
	var spawn = get_Spawnpoint(id)
	$Robot.respawn_point = spawn.get_global_transform().origin
	$Robot.spawn()
	
func get_Spawnpoint(id):
	if(id == 3):
		return $containsLevel4/containsPoints/Spawnpoint/Respawnpoint
	if(id == 2):
		return $containsLevel3/containsPoints/Spawnpoint/Respawnpoint
	if(id == 1):
		return $containsLevel2/containsPoints/Spawnpoint/Respawnpoint
	else:
		return $containsLevel1/containsPoints/Spawnpoint/Respawnpoint





func _on_openPost(attempts, time, object):
	pass # Replace with function body.
