extends State

class_name ArgusJumpState

@export var landing_state : State

func on_enter():
	print("jump state activated")
	playback.travel("idle")
	playback.travel("jump")
	character.velocity.y -= 1500
	next_state = landing_state
	
#func on_exit():
	#playback.travel("idle")
