extends Spatial

onready var anim_player = $AnimationPlayer

var player = false

func _ready():
	anim_player.play("move")

func do_animation():
	player = true

func _physics_process(delta):
	if player:
		if !anim_player.is_playing():
			player = false
		anim_player.play("move")
