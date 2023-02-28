extends KinematicBody

# positive y-speed when jumping (pixels per second)
const JUMP_FORCE = 8     
# negative y-acceleration to display gravity
const GRAVITY = 16 
# maximum y-speed the player can have downwards
const MAX_FALL_SPEED = 20       
# maximum y-speed the player can have without using any abilities
# when using an ability, player can wlek twice as fast (15)
const MAX_MOVE_SPEED = 5.5 

# holds the information of the current velocioty of the player
var velocity = Vector3.ZERO

# determines the direction the player is looking
var facing_right = true


# id true while the player is in the air
var jumping = false
# is true when the player is able two make his first jump
var able = true

# is true when the level allows to jump mid air once
var doublejump = false # true

# is true when the player is able to make the second jump
var able2 = false
# is true when the second jump was used
var jumping2 = false


# is true when the level allows to activate the ability speedboost
var speedboost = false # true  

# the ability will move the player double the speed for 5 seconds
const ABILITY_DURATION = 5  
# to measure when the ability runs out
var duration = ABILITY_DURATION
# cooldown time until the player can activate the ability again
const ABILITY_COOLDOWN = 10
# to measure time of cooldown
var cooldown = ABILITY_COOLDOWN

# variables to determine which animition to play when starting or stopping to walk
# e.g. while accerating the player leans forward
var lean = 0
var leanchange = 0.2

# variables to determine which respawnpoint is currently active and where it is
var respawn_point = Vector3(0,1,0)
var current_checkpoint = null

# variable for tries needed and the time played
var tries = 1
# 
var timer_started = false
var game_timer = 0

#caches path for creating instance of Bullet.tscn
const bulletpath = preload("res://Scenes/Player_Bullet.tscn")
var allowShoot = true
var stimer = null
var bulletdelay = 1

#creates AudioPlayer to play audio
var player = AudioStreamPlayer.new()

# instance to play eanimations
onready var anim_player = $Graphics/RBGODO/AnimationPlayer
onready var cam_player = $AnimationPlayer

onready var root = get_parent().get_parent()
onready var level_id = root.level_id
# when starting the scene, this will set conditions
func _ready():
	# target fps, should be so the wheel does not appear to spin in the wrong direction when moving
	Engine.target_fps = 400
	
	$Graphics/RBGODO/AnimationTree.active = true
	$Graphics/RBGODO/AnimationTree.set("parameters/Blend_Idle_Drive/blend_amount",0)
	
	#timer for shoot delay
	#stimer = Timer.new()
	#stimer.set_one_shot(true)
	#stimer.set_wait_time(bulletdelay)
	#stimer.connect("timeout", self, "on_stime_complete")
	#add_child(stimer)

# Hauptfunktion der Physikalischen Prozesse
func _physics_process(delta): 
	# will get the direction of movement in a vector (x and y can be 1 or -1)
	var input = get_input(delta)
	
	
	#all animations are beeing handled here
	if !IsMovingRounded():
		if lean > 0:
			lean = lean - leanchange
		$Graphics/RBGODO/AnimationTree.set("parameters/Blend_Idle_Drive/blend_amount",lean)
	
	if input.x == 1 or input.x == -1:
		if lean < 1:
			lean = lean + leanchange
		$Graphics/RBGODO/AnimationTree.set("parameters/Blend_Idle_Drive/blend_amount",lean)
	
	if Input.is_action_pressed("jump") && able:
		$Graphics/RBGODO/AnimationTree.set("parameters/Blend_jump/active",true)
		
	elif Input.is_action_pressed("jump") && able2 && doublejump:
		$Graphics/RBGODO/AnimationTree.set("parameters/Blend_doublejump/active",true)
		
	if Input.is_action_pressed("shoot"):
		$Graphics/RBGODO/AnimationTree.set("parameters/Blend_Shoot_Ani/active",true)
#		if allowShoot:
#			shoot()
	
	# determines x velovity
	get_v_x(delta, input.x)
	# determines y velovity
	get_v_y(delta, input.y)
	
	# will flip the facing of the player, when moving opposite direction
	if input.x < 0 and facing_right:
		flip()
	if input.x > 0 and !facing_right:
		flip()
		
	# if on floor the variables concerning the jumps have to be reset
	
	#if !is_on_floor():
		# this is so the second jump can be made if driving of a ledge instead of jumping the first time
		#jumping = true
	
	
	var snap = Vector3.ZERO #Vector3.DOWN if not jumping else Vector3.ZERO
	move_and_slide_with_snap(velocity, snap, Vector3.UP, true, 4, deg2rad(60))
	
	#move_and_slide(velocity, Vector3.UP, true, 4, deg2rad(60))
	
	if is_on_floor():
		able = true
		able2 = false
		jumping = false
		jumping2 = false
	else:
		# this is so the second jump can be made if driving of a ledge instead of jumping the first time
		jumping = true
	
	if timer_started:
		game_timer += delta
	
	var cur_pos = Vector3.ZERO
	cur_pos = transform.origin
	if cur_pos.y < -10:
		die()
	






func IsMovingRounded():
		return (abs(velocity.length()) > 1)

# get_input returns a vector with x and y directions in form of signs (x and y can be 1 or -1)
func get_input(delta):
	var input = Vector3.ZERO
	
	if Input.is_action_pressed("move_right"):
		input.x += 1
	if Input.is_action_pressed("move_left"):
		input.x -= 1
	if Input.is_action_pressed("jump"):
		input.y += 1
	# only when the jump buitton is released after the first jump, the player can make the second jump
	if Input.is_action_just_released("jump") && jumping && !jumping2:
		able2 = true
	if Input.is_action_pressed("crouch"):
		input.y -= 1
		
	
	if Input.is_action_pressed("ability") && speedboost && cooldown == ABILITY_COOLDOWN:
		duration -= delta
	input = do_ability(delta, input)
	
	return input




# when the ability speed boost is activated, the x values in the input vector are set to the 
# absolute value of 2 so the speed is multiplied with 2
# also measures whether the ability is still on cooldown
func do_ability(delta, input):
	
	if duration == ABILITY_DURATION && cooldown == ABILITY_COOLDOWN:
		return input
		
	elif cooldown != ABILITY_COOLDOWN:
		cooldown -= delta
		if cooldown < delta:
			cooldown = ABILITY_COOLDOWN
		return input
		
	elif duration != ABILITY_DURATION:
		duration -= delta
		if duration < delta:
			duration = ABILITY_DURATION
			cooldown -= delta
		input.x *= 2
		return input
		
	else:
		return input
	 




# get_v_x sets the new velocity on the x-axis inside the global variable velocity (type: Vector3D)
func get_v_x(delta, dir):
	# delta is a set value of frames per second so when calculating velocity, it will be independent
	# of fps but will give the same position, as now speeds can be calculated in pixels/second instead
	
	var temp_dir = dir
	
	# when moving and the keys are no longer held down, this will provide a smooth force in opposite
	# directrion of the current velocity, so it seems as the player is breaking
	if dir == 0:
		# when no keys (a or d) held input.x == 0 so opposite direction is applied
		if velocity.x < -0.5:
			dir += 1
		elif velocity.x > 0.5:
			dir -= 1
		# if the value is below .5 in each direction the player will stand still or he will slide 
		# unintendedly over the ground
		else:
			velocity.x = 0
	
	# this formula will give accelerated movement
	velocity.x += dir + 0.25 * dir * MAX_MOVE_SPEED * delta
	
	# this will give temp_dir the direction of the motion in 1 or -1
	if velocity.x != 0:
		temp_dir = velocity.x / abs(velocity.x)
	
	# max Speed will be determined so dependent of the ability speedboost
	var maxS = MAX_MOVE_SPEED
	if duration < ABILITY_DURATION:
		maxS *= 2
	
	# if the velocity is bigger then the max, it wil be cut down to max Velocity	
	if velocity.x > maxS || velocity.x < -maxS:
		velocity.x = temp_dir * maxS
	



# this function will determine the speed in y-direction
func get_v_y(delta, dir):
	
	# when mid-air and the player hits the ceiling, he should not stick at it because of momentum
	# for that to happen it is cut down to a specific value, that makes it feel more natural
	if is_on_ceiling():
		velocity.y = 0
		
		
	# this bit will calculate the new y velocity as a result of gravity
	velocity.y -= GRAVITY * delta
	if velocity.y < -MAX_FALL_SPEED:
		velocity.y = -MAX_FALL_SPEED
	
	# so the player constantly is pushed into the ground and will not float on the ground
	if !jumping:
		velocity.y = -0.1
	
	# this part will disable the player to jump for the first time when falling of a ledge
	# and enabling the player to take the second jump instead
	if able && jumping:
		able = false
		able2 = true
		
	# if space is pressed the player will jump if able to
	if dir == 1:
		# if not already jumping and able to jump
		if !jumping && able:
			jump(dir)
		
		# if not haveing used the second jump, if able to jump twice and the feature
		# doubljump is active
		elif !jumping2 && able2 && doublejump:
			jump2(dir)
	
	# if s is pressed player will quickly drop down to the floor
	elif dir == -1:
		crouch(dir)
	
	
# this will apply the jump force to the y-velocity of the player
func jump(dir):
	velocity.y = JUMP_FORCE
	# upon called player is now jumping
	jumping = true
	# player is not anymore able to use first jump
	able = false
	#plays jumpsound
	self.add_child(player)
	player.stream = load("res://Jumpsound2.wav")
	player.play()

# this will apply a part of jump force to the y-velocity of the player as second jump
func jump2(dir):
	velocity.y = JUMP_FORCE * 3/4
	# player has used second jump
	jumping2 = true
	# player is not anymore able to use second jump
	able2 = false
	

# this will apply high negative y-velocity so the player is down to the ground very quickly
func crouch(dir):
	velocity.y = -(MAX_FALL_SPEED / 2)

# if facing the wrong way, this method will flip the direction the player is looking to
func flip():
	facing_right = !facing_right
	for x in range(15):
		$Graphics.rotation_degrees.y += 12
		yield(get_tree().create_timer(0.001), "timeout")



# if called, the player will die, respawn and the try-counter goes up by 1
func die():
	
	transform.origin = respawn_point
	
	#plays deathsound
	self.add_child(player)
	player.stream = load("res://Death_Sound2.wav")
	player.play()
	
	tries += 1
	
	print()
	print("You died!")
	print("Attempts: " + String(tries))
	print("Time:     " + String(game_timer))
	print()

func spawn():
	level_id = root.level_id
	#tries = root.game_data["progress"]["level_" + str(level_id)]["attempts"]
	self.show()
	transform.origin = respawn_point

func _on_RestartButton_pressed():
	die()

# function handles collision with areas depending on their group
# if killblock's area has group killing, player will die
func _on_CollisionArea_area_entered(area):
	print("Robot collided with area "+ area.get_parent().name + ": ")
	print(area.get_groups())
	
	#fallunterscheidung:
	
	# killing areas
	if area.is_in_group("killing"):
		die()
		
	# druckplatte (sendet signal an tür) + timer
	
	# detection zone für fallingBlock / squashing block
	if area.is_in_group("detectionZone"):
		area.get_parent().do_animation()
		
	# handle end of Level point
	if area.is_in_group("endpoint"):
		print("robot: " + str(tries) + ", " + "%.2f" % game_timer)
		area.get_parent().end_game(str(tries), "%.2f" % game_timer, true)
		#root.game_data["progress"]["level_" + str(level_id + 1)]["attempts"] = tries
		tries = 1
		#root.game_data["progress"]["level_" + str(level_id + 1)]["time"] = game_timer
		game_timer = 0
		#root.game_data["progress"]["level_" + str(level_id + 1)]["finished"] = true
		
		#wenn item eingesammelt
			#root.game_data["progress"]["level_" + str(level_id)]["item_collected"] = true
	# collectable
	
	
	
	
	

#func shootBulletInstances():
	#var bullet = bulletpath.instance()
	
	#get_parent().add_child(bullet)
	#print(bullet)
	#print($BulletOrigin.get_global_transform().origin)
	#bullet.translation = $BulletOrigin.global_transform.origin

#func shoot():
	#shootBulletInstances()
	#yield(get_tree().create_timer(0.5), "timeout")
	#shootBulletInstances()
	#allowShoot = false
	#stimer.start()

#func on_stime_complete():
	#allowShoot = true

func do_cam(move_back):
	if move_back:
		cam_player.play("moveCamL")
	else:
		cam_player.play("moveCamR")


func _on_PreGameScreen_chooseLevel(id):
	if id == 0:
		doublejump = false
		speedboost = false
	elif id == 1:
		doublejump = true
		speedboost = false
	elif id == 2:
		doublejump = false
		speedboost = true
	elif id == 3:
		doublejump = true
		speedboost = true





func _on_Root_start_timer_robot():
	timer_started = true




func _on_Root_stop_timer_robot():
	timer_started = false
