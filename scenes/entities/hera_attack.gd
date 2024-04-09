extends State

class_name HeraAttackState

var sceptre_spawn_locations = [Vector2(-100,0), Vector2(150,0), Vector2(300,0), Vector2(12100,0)]

@onready var sceptre_container = $ProjectileContainer
@onready var timer := $Timer
@export var playerStateMachine : PlayerStateMachine
@export var return_state : State

var sceptre = preload("res://scenes/entities/hera_sceptre.tscn")

func on_enter():
	playback.travel("attack")
	
	for i in range(-100, 12401, 250):
		if(randi() % 5 > 1):
			var sceptre = sceptre.instantiate()
			sceptre_container.add_child(sceptre)
			sceptre.global_position = Vector2(i, 0)

func _on_timer_timeout():
	next_state = return_state
