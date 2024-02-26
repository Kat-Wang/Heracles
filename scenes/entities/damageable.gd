extends Node

class_name Damageable

signal on_hit(node : Node, damage_taken : int)

@export var health : float = 5

func hit(damage : int):
	health -= damage
	
	emit_signal("on_hit", get_parent(), damage)
	
	if health <= 0:
		get_parent().queue_free()
