extends CharacterBody2D

var vel = Vector2.ZERO
const MAX_SPEED: int = 80
const ACCELERATION: int = 500
const FRICTION: int = 500

enum State{
	MOVE,
	ROLL,
	ATTACK
}

var state = State.MOVE

@onready var animationPlayer = $AnimationPlayer
@onready var animationTree = $AnimationTree
@onready var animationState = animationTree.get("parameters/playback")

func _ready():
	animationTree.active = true
	
func _process(delta):
	match state:
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
		
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	if (input_vector != Vector2.ZERO):
		animationTree.set("parameters/Idle/blend_position", input_vector)
		animationTree.set("parameters/Run/blend_position", input_vector)
		animationTree.set("parameters/Attack/blend_position", input_vector)
		animationState.travel("Run")
		vel = vel.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
		#vel += input_vector * ACCELERATION * delta
		#vel = vel.limit_length(MAX_SPEED)
	else:
		animationState.travel("Idle")
		vel = vel.move_toward(Vector2.ZERO, FRICTION * delta)
	velocity = vel 
	move_and_slide()
	
	if (Input.is_action_just_pressed("attack")):
		state = State.ATTACK
	
func attack_state(delta):
	print("attack button pressed!")
	animationState.travel("Attack")
	vel = vel.move_toward(Vector2.ZERO, FRICTION * delta)
	velocity = vel
	move_and_slide()

func attack_animation_finished():
	state = State.MOVE

func roll_state(_delta):
	pass
