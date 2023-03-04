extends Spatial


onready var anim_player = $AnimationPlayer

func _ready():
	$Timer.start()

func _on_Timer_timeout():
	anim_player.play("move_platform")
