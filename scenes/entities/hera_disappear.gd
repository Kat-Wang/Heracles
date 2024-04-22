extends State

class_name HeraDisappear

var teleport_locations = [Vector2(2953,990), Vector2(5373,389), Vector2(7444, 550)]

@onready var timer := $Timer
@export var damageable : Damageable
@export var playerStateMachine : PlayerStateMachine
@export var return_state : State
@export var teleport_sfx : AudioStreamPlayer2D

var last_idx = -1

func on_enter():
	teleport_sfx.play()
	playback.travel("teleport_out")
	timer.start()

func _on_timer_timeout():
	next_state = return_state

	if damageable.health < 3:
		var idx = generate_teleport_idx()
		character.global_position = teleport_locations[idx]
		
# generate a teleport idx that is different than the last time the function was called (to ensure she actually moves each time)
func generate_teleport_idx():
	var idx = randi_range(0, teleport_locations.size() - 1)
	while idx == last_idx:
		idx = randi_range(0, teleport_locations.size() - 1)
	last_idx = idx
	return idx
		
