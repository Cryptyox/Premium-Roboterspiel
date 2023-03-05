extends Area

func _ready():
	activate()
	$AnimationPlayer.play("idle")

func deactivate():
	self.hide()

func activate():
	self.show()
