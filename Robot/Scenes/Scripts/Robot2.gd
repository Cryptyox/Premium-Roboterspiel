extends KinematicBody

const JUMP_FORCE = 10     
const GRAVITY = 16 
const MAX_FALL_SPEED = 30       
const MAX_MOVE_SPEED = 7.5 

var velocity = Vector3.ZERO

var facing_right = true

var jumping = false
var able = true

# kann in der luft einmal springen
var doublejump = true

var jumping2 = false
var able2 = false

# läuft für 'duration' sekunden doppelt so schnell
var speedboost = true
const ABILITY_DURATION = 5
var timer = ABILITY_DURATION
const ABILITY_COOLDOWN = 5
var cooldown = ABILITY_COOLDOWN

onready var anim_player = $Graphics/AnimationPlayer



func _ready():
	Engine.target_fps = 400





# Hauptfunktion der Physikalischen Prozesse
func _physics_process(delta):   
	var oldx = velocity.x
	var oldy = velocity.y
	
	var input = get_input(delta)
	
	get_v_x(delta, input.x)
	get_v_y(delta, input.y)
	
	if input.x < 0 and facing_right:
		flip()
	if input.x > 0 and !facing_right:
		flip()
	
	#var snap = Vector3.DOWN if not jumping else Vector3.ZERO
	#move_and_slide_with_snap(velocity, snap, Vector3.UP, true, 4, deg2rad(60))
	
	move_and_slide(velocity, Vector3.UP, true, 4, deg2rad(60))
	
	if is_on_floor():
		able = true
		able2 = false
		jumping = false
		jumping2 = false
	else:
		jumping = true
	
	





# Die Funktion get_input() fragt den input bezüglich der Bewegung des Roboters
# im aktuellen Frames ab. Es wird ein 3d Vektor erstellt der per Vorzeichen die
# Richtung der Bewegung festlegt
func get_input(delta):
	var input = Vector3.ZERO
	
	
	if Input.is_action_pressed("move_right"):
		input.x += 1
	if Input.is_action_pressed("move_left"):
		input.x -= 1
	if Input.is_action_pressed("jump"):
		input.y += 1
	if Input.is_action_just_released("jump") && jumping && !jumping2:
		able2 = true
	if Input.is_action_pressed("crouch"):
		input.y -= 1
		
	
	if Input.is_action_pressed("ability") && speedboost && cooldown == ABILITY_COOLDOWN:
		timer -= delta
	input = do_ability(delta, input)
	
	return input




# Die Funktion trägt dazu bei, den speed bost für die Zeit aufrechtzuerhalten
func do_ability(delta, input):
	
	if timer == ABILITY_DURATION && cooldown == ABILITY_COOLDOWN:
		return input
		
	elif cooldown != ABILITY_COOLDOWN:
		cooldown -= delta
		if cooldown < delta:
			cooldown = ABILITY_COOLDOWN
		return input
		
	elif timer != ABILITY_DURATION:
		timer -= delta
		if timer < delta:
			timer = ABILITY_DURATION
			cooldown -= delta
		input.x *= 2
		return input
		
	else:
		return input
	 




# get_v_x berechnet die Geschwindigkeit in x-Richtung
func get_v_x(delta, dir):
	# delta ist die Anzahl der Frames innerhalb einer Sekunde
	# 60 FPS --> delta = 1/60 
	# bei Berechnung von Geschwindigkeit ohne delta, Charakter langsamer
	# wenn weniger Frames
	# Bei Berechnung mit delta, kann Geschwindigkeit in pixel pro sekunde
	# angegeben werden
	# Setzt das Vorzeichen für die Bewegung in x-Richtung
	
	var temp_dir = dir
	if dir == 0:
		if velocity.x < -0.5:
			dir += 1
			play_anim("Break")
		elif velocity.x > 0.5:
			dir -= 1
			play_anim("Break")
		else:
			velocity.x = 0
	else:
		if velocity.y == 0:
			play_anim("Accellerate")
		
		play_anim("Drive")
	velocity.x += dir + 0.25 * dir * MAX_MOVE_SPEED * delta
	
	 
	if velocity.x != 0:
		temp_dir = velocity.x / abs(velocity.x)
	
	var maxS = MAX_MOVE_SPEED
	if timer < ABILITY_DURATION:
		maxS *= 2
		
	if velocity.x > maxS || velocity.x < -maxS:
		velocity.x = temp_dir * maxS
	




func get_v_y(delta, dir):
	
	# stop_on_ceiling
	if is_on_ceiling():
		velocity.y = 0
		
		
	# do_gravity
	velocity.y -= GRAVITY * delta
	if velocity.y < -MAX_FALL_SPEED:
		velocity.y = -MAX_FALL_SPEED
	
	# so the player constantly is pushed into the ground
	if !jumping:
		velocity.y = -0.1
	
	# if space is pressed
	if dir == 1:
		if !jumping && able:
			jump(dir)
		
		elif !jumping2 && able2 && doublejump:
			jump2(dir)
	
	# if s is pressed
	elif dir == -1:
		crouch(dir)
	
	

func jump(dir):
	velocity.y = JUMP_FORCE
	jumping = true
	able = false
	play_anim("Jump")


func jump2(dir):
	velocity.y = JUMP_FORCE * 3/4
	jumping2 = true
	able2 = false
	


func crouch(dir):
	if dir == -1:
		velocity.y = -(MAX_FALL_SPEED / 2)


func flip():
	$Graphics.rotation_degrees.y += 180
	facing_right = !facing_right


func play_anim(anim):
	if anim_player.current_animation == anim:
		return
	anim_player.play(anim)
