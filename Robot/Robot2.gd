extends KinematicBody

const JUMP_FORCE = 9     
const GRAVITY = 16 
const MAX_FALL_SPEED = 30       
const MAX_MOVE_SPEED = 7.5 

var facing_right = true
var jumping = false

var doublejump = false
var speedboost = false

onready var anim_player = $Graphics/AnimationPlayer


# delta ist die Anzahl der Frames innerhalb einer Sekunde
	# 60 FPS --> delta = 1/60 
	# bei Berechnung von Geschwindigkeit ohne delta, Charakter langsamer
	# wenn weniger Frames
	# Bei Berechnung mit delta, kann Geschwindigkeit in pixel pro sekunde
	# angegeben werden
	# Setzt das Vorzeichen für die Bewegung in x-Richtung

func _ready():
	Engine.target_fps = 60


func get_input(delta):
	
	# Vektor mit Richtung der Bewegung des Frames
	var input = Vector3.ZERO
	if Input.is_action_pressed("move_right"):
		input.x += 1
	if Input.is_action_pressed("move_left"):
		input.x -= 1
	if Input.is_action_pressed("jump"):
		input.y += 1
	if Input.is_action_pressed("crouch"):
		input.y -= 1

func do_velocity_x(delta):
	x_velo += move_dir * MOVE_SPEED * delta
	if x_velo > MOVE_SPEED || x_velo < -MOVE_SPEED:
		x_velo = move_dir * MOVE_SPEED


func do_velocity_y(delta):
	var just_jumped = false
	var grounded = is_on_floor()
	y_velo -= GRAVITY * delta
	if y_velo < -MAX_FALL_SPEED:
		y_velo = -MAX_FALL_SPEED
	
	if grounded:
		y_velo = -0.1
		if Input.is_action_pressed("jump"):
			y_velo = JUMP_FORCE
			just_jumped = true
	
	if Input.is_action_pressed("crouch"):
			y_velo = -(MAX_FALL_SPEED)/2

func flip():
	$Graphics.rotation_degrees.y *= -1
	facing_right = !facing_right

func _physics_process(delta):   
	
	var input = get_input(delta)
	
	var velocity = Vector3.ZERO
	velocity.x = get_v_x(delta, input.x)
	velocity.y = get_v_y(delta, input.y)
	
	if move_dir < 0 and facing_right:
		flip()
	if move_dir > 0 and !facing_right:
		flip()
	
	var snap = Vector3.DOWN if not jumping else Vector3.ZERO
	move_and_slide_with_snap(Vector3(x_velo, y_velo, 0), snap, Vector3.UP, true, 4, deg2rad(60))
