extends CharacterBody2D 

var vel = Vector2.ZERO # velocity vector2d 0
const MAX_SPEED: int = 80 # max speed of char
const ACCELERATION: int = 500 # acclrn of char
const FRICTION: int = 500 # friction of char movement

enum State{ # State machine for char
	MOVE,
	ROLL,
	ATTACK
}

var state = State.MOVE #by default state variable will hold MOVE enum state

@onready var animationPlayer = $AnimationPlayer # accessing animation player node
@onready var animationTree = $AnimationTree # accessing animation tree node
@onready var animationState = animationTree.get("parameters/playback") # access animation player

func _ready(): # runs on start once 
	animationTree.active = true # setting animation tree to true
	
func _process(delta): # updates every frames 1/60th
	match state: # basically switch statement
		State.MOVE: 
			move_state(delta) 
		State.ATTACK:
			attack_state(delta)
		State.ROLL:
			roll_state(delta)

func move_state(delta):
	#if Input.is_action_pressed("ui_right"):
		#vel.x += 10
	#elif Input.is_action_pressed("ui_left"):
		#vel.x -= 10
	#else:
		#vel.x = 0
		
	var input_vector = Vector2.ZERO # will hold 1 or 0 on x or y
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized() # normalize (1) across 2d movements
	if (input_vector != Vector2.ZERO): # if inp vec is > 0
		animationTree.set("parameters/Idle/blend_position", input_vector) # setting Idle animation
		animationTree.set("parameters/Run/blend_position", input_vector) # setting Run animation
		animationTree.set("parameters/Attack/blend_position", input_vector) # setting attack animation
		animationState.travel("Run") # if inp vec > 0 then animation player -> Run
		vel = vel.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta) # vel will move towards inp vec with speed and start with accln
		#vel += input_vector * ACCELERATION * delta
		#vel = vel.limit_length(MAX_SPEED)
	else:
		animationState.travel("Idle") # if inp vec 0 then idle
		vel = vel.move_toward(Vector2.ZERO, FRICTION * delta) # vel will move towards 0 with friction 
	velocity = vel 
	move_and_slide() # necessary for basic moving and calcs also velocity is a built in var
	
	if (Input.is_action_just_pressed("attack")): # if mouse1 pressed
		state = State.ATTACK # change state to attack
	
func attack_state(delta): # when in attack state
	print("attack button pressed!") # debug print
	animationState.travel("Attack") # animation player -> attack
	vel = vel.move_toward(Vector2.ZERO, FRICTION * delta) # moves towards 0 with friction when attacking so it doesnt slip when in animation
	velocity = vel 
	move_and_slide()

func attack_animation_finished():
	state = State.MOVE # attack over then move state, this is used in animation player

func roll_state(_delta): # when rolling
	pass
