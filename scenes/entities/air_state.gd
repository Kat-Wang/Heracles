extends State

class_name AirState

@export var landing_state : State
@export var attack_state : State
@export var double_jump_velocity : float = -400.0
@export var landing_sfx : AudioStreamPlayer2D

var has_doubled_jumped = false

func state_process(delta):
	if player.is_on_floor():
		landing_sfx.play()
		next_state = landing_state

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
	player.velocity.y = double_jump_velocity
	has_doubled_jumped = true
	playback.travel("jump")
