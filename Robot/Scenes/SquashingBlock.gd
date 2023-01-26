extends Spatial

onready var anim_player = $AnimationPlayer

var player = false

func do_animation():
	player = true

func _physics_process(delta):
	if player:
		if !anim_player.is_playing():
			player = false
		anim_player.play("move_block")
