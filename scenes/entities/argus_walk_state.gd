extends State

class_name ArgusWalkState

@export var jump_state : State
@export var playerStateMachine : PlayerStateMachine

var walk_timer : Timer

func on_enter():
	playback.travel("walk")
	
	walk_timer = $WalkTimer
	walk_timer.wait_time = randi_range(3.0, 10.0)
	walk_timer.start()

func _on_walk_timer_timeout():
	print("walk timer timeout")
	emit_signal("interrupt_state", jump_state)
