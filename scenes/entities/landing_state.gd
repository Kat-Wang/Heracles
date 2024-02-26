extends State

class_name LandingState

@export var ground_state : State

#The main purposes of landing state are to play landing SFX
func _on_animation_tree_animation_finished(anim_name):
	#if anim_name == "fall":
	next_state = ground_state
