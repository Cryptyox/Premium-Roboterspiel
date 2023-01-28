extends Spatial

const MAX_SPEED = 10

var velocity = Vector3.ZERO
var direction = Vector3.ZERO

func _physics_process(delta):
	
	velocity.x = direction.x * MAX_SPEED
	velocity.y = direction.y * MAX_SPEED
