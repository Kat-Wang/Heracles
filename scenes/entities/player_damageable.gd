extends Damageable

signal player_died

func hit(damage : int, knockback_direction : Vector2):
	print("hit")
	health -= damage
	emit_signal("on_hit", get_parent(), damage, knockback_direction)


func _on_animation_tree_animation_finished(anim_name):
	if(anim_name == dead_animation_name):
		get_parent().queue_free()
		player_died.emit()
