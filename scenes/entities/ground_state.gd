extends State

class_name GroundState

@export var jump_velocity = -900.0
@export var air_state : State
@export var attack_state : State
@export var jump_sfx : AudioStreamPlayer2D
@export var wall_jump_velocity = -800.0

func state_process(delta):
	if !character.is_on_floor():
		next_state = air_state
		

func state_input(event: InputEvent):
	if event.is_action_pressed("up"):
		jump()
	if event.is_action_pressed("attack"):
		attack()
	
func jump():
	character.velocity.y = jump_velocity
	jump_sfx.play()
	#next_state = air_state
	playback.travel("jump")

func attack():
	next_state = attack_state
	playback.travel("attack")

