extends State

class_name ArgusJumpState

@export var landing_state : State

func on_enter():
	print("jump state activated")
	playback.travel("jump")
	character.velocity.y -= 700

func _on_timer_timeout():
	next_state = landing_state
