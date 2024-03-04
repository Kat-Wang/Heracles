extends State

class_name HitState

@onready var timer := $Timer

@export var damageable : Damageable
@export var playerStateMachine : PlayerStateMachine
@export var dead_state : State
@export var knockback_speed : float = 100.0
@export var return_state : State

func _ready():
	damageable.connect("on_hit", on_damageable_hit)

func on_enter():
	timer.start()
	
func on_damageable_hit(node : Node, damage_amount : int, knockback_direction : Vector2):
	if damageable.health >= 0:
		print("knockback direction: ", knockback_direction)
		if knockback_direction == character.direction:
			character.velocity += knockback_speed * knockback_direction
		else:
			character.velocity = knockback_speed * knockback_direction
		print("charcter velocity: ", character.velocity)
		emit_signal("interrupt_state", self)
		#playback.travel("hit")
	else:
		emit_signal("interrupt_state", dead_state)
		playback.travel("death")

func on_exit():
	character.velocity = Vector2.ZERO

func _on_timer_timeout():
	next_state = return_state
