extends Node

class_name State

signal interrupt_state(new_state : State)

#@export var can_move : bool = true

var character : CharacterBody2D
var playback : AnimationNodeStateMachinePlayback
var next_state : State

func _ready():
	pass
	
func _physics_process(delta):
	pass
