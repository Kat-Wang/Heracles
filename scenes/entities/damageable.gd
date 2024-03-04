extends Node

class_name Damageable

signal on_hit(node : Node, damage_taken : int, knockback_direction : Vector2)

@export var health : float = 4
@export var dead_animation_name : String = "death"

func hit(damage : int, knockback_direction : Vector2):
	print("hit")
	health -= damage
	emit_signal("on_hit", get_parent(), damage, knockback_direction)

func _on_animation_tree_animation_finished(anim_name):
	if(anim_name == dead_animation_name):
		get_parent().queue_free()
		get_tree().change_scene_to_file("res://scenes/game.tscn")
