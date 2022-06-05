extends KinematicBody2D

const ACCELERATION = 500
const MAX_SPEED = 400
const FRICTION = 100

var velocity = Vector2.ZERO
var roll_vector = Vector2.DOWN
#var stats = PlayerStats

func _ready():
	randomize()# randomizes the seed for the game, godot uses a set seed for the game by default

func _physics_process(delta):
	move_state(delta)

func move_state(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	input_vector.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)

	move()

func move():
	velocity = move_and_slide(velocity)
