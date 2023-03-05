extends Area

func _ready():
	activate()

func deactivate():
	self.hide()

func activate():
	self.show()
