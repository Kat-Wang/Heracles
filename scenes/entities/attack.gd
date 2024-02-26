extends State

@export var return_state : State
@export var ground_state: State
@export var landing_state: State
@export var attack_sfx: AudioStreamPlayer2D


func state_input(event : InputEvent):
	if event.is_action_pressed("attack"):
		pass

func _on_animation_tree_animation_finished(anim_name):
	if anim_name == "attack":
		attack_sfx.play()
		return_state =  ground_state if player.velocity.y == 0 else landing_state
		next_state = return_state
		playback.travel("move")
		
