extends State

class_name ArgusWalkState

@export var jump_state : State

func on_enter():
	print("walk state activated")

func state_process(delta):
	#create 1 in 5 chance at each delta that Argus will jump
	var rand_num =  randi() % 200 + 1
	print(rand_num)
	if rand_num == 5:
		emit_signal("interrupt_state", jump_state)
