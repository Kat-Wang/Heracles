extends State

class_name ArgusWalkState

@export var jump_state : State

func on_enter():
	print("walk state activated")

func state_process(delta):
	var rand_num =  randi() % 200 + 1
	print(rand_num)
	if rand_num == 5:
		emit_signal("interrupt_state", jump_state)
