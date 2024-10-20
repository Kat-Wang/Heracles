extends State

class_name AirState

@export var landing_state : State
@export var attack_state : State
@export var wall_state : State
@export var double_jump_velocity : float = -800.0
@export var landing_sfx : AudioStreamPlayer2D
@export var wall_jump_velocity = -800.0
@export var knockback_speed : float

var has_doubled_jumped = false

func state_process(delta):
	if character.is_on_floor():
		landing_sfx.play()
		next_state = landing_state
	if character.is_near_wall():
		next_state = wall_state

func state_input(event : InputEvent):
	if event.is_action_pressed("up") && !has_doubled_jumped:
		double_jump()
	if event.is_action_pressed("attack"):
		next_state = attack_state
		playback.travel("attack")

func on_exit():
	if(next_state == landing_state):
		playback.travel("fall")
		has_doubled_jumped = false

func double_jump():
	character.velocity.y = double_jump_velocity
	has_doubled_jumped = true
	playback.travel("jump")


func wall_jump():
	#velocity defined twice in ground and air states, make sure equal
	character.velocity.y = wall_jump_velocity
	character.velocity.x = knockback_speed * -character.last_direction
	playback.travel("wall")
	
