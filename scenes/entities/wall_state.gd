extends State

class_name WallState

@export var landing_state : State
@export var attack_state : State
@export var wall_state : State
@export var air_state : State
@export var double_jump_velocity : float = -800.0
@export var landing_sfx : AudioStreamPlayer2D
@export var wall_jump_velocity = -800.0
@export var knockback_speed : float

var has_doubled_jumped = false

func state_process(delta):
	if character.is_on_floor():
		landing_sfx.play()
		next_state = landing_state
	elif !character.is_on_wall():
		next_state = air_state
	elif character.is_on_wall():
		next_state = wall_state

func state_input(event : InputEvent):
	if event.is_action_pressed("up"):
		wall_jump()
	if event.is_action_pressed("attack"):
		next_state = attack_state
		playback.travel("attack")

func on_exit():
	if(next_state == landing_state):
		playback.travel("fall")
		has_doubled_jumped = false

func wall_jump():
	#velocity defined twice in ground and air states, make sure equal
	character.velocity.y = wall_jump_velocity
	character.velocity.x = knockback_speed * -character.last_direction
	playback.travel("wall")
	
