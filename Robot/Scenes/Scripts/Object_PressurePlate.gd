
extends Spatial

onready var anim_player = $AnimationPlayer

var player = false
#var timer1 = 2

#func _ready():
#	anim_player.play("move_block")

func do_animation():
	player = true

func _physics_process(delta):
	#timer1 = timer1 - delta
	if player:
		if !anim_player.is_playing():
			anim_player.play("Pressure_Plate_down")
		player = false
#	if player nicht in area --> hoch
#	if timer1 <= 0:
#		if !anim_player.is_playing():
#			anim_player.play("Pressure_Plate_up")
#		player = false
