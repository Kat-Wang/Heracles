extends State

class_name HeraAppear

@onready var timer := $Timer
@export var playerStateMachine : PlayerStateMachine
@export var return_state : State

func on_enter():
	timer.start()

func _on_timer_timeout():
	next_state = return_state
