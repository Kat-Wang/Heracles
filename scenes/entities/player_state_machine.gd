extends Node

class_name PlayerStateMachine

@export var current_state : State
@export var character : CharacterBody2D
@export var animation_tree : AnimationTree

var states : Array[State]

func _ready():
	#print("Current State: ", current_state)
	
	for child in get_children():
		if(child is State):
			states.append(child)
			
			child.character = character
			child.playback = animation_tree["parameters/playback"]
			
			if child is AirState || child is WallState:
				child.knockback_speed = 2000.0
			if child is HitState:
				child.knockback_speed = 300.0
			#Connect each type of State to the interrupt signal
			#Allows state interruption for all the states (which characterstatemachine handles)
			child.connect("interrupt_state", on_state_interrupt_state)
			
		else:
			push_warning("Child " + child.name + "is not a State for PlayerStateMachine")

func _physics_process(delta):
	if(current_state.next_state != null):
		switch_states(current_state.next_state)
	
	current_state.state_process(delta)
	
func check_if_can_move():
	return current_state.can_move

func switch_states(new_state : State):
	if current_state != null:
			current_state.on_exit()
			current_state.next_state = null
			
	current_state = new_state
	current_state.on_enter()
	#print(character.name, " is switching to state: ", current_state)

func _input(event : InputEvent):
	current_state.state_input(event)

func on_state_interrupt_state(new_state : State):
	switch_states(new_state)
	
