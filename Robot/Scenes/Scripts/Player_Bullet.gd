extends Area

var speed = 15
var veocity = Vector3()

onready var timer = get_node("Timer")

func _ready():
	
	timer.set_wait_time(5)
	
	timer.start()


func start(xform):
	
	var tranform = xform
	var velocity = +transform.basis.x * speed

func _process(delta):
	transform.origin += veocity * delta

# handle collision

# handle timer
	#queue_free()
