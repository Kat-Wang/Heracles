extends HitState

func on_damageable_hit(node : Node, damage_amount : int, knockback_direction : Vector2):
	playback.travel("damage")
	if damageable.health >= 0:
		if knockback_direction == character.direction:
			character.velocity += knockback_speed * knockback_direction
		else:
			character.velocity = knockback_speed * knockback_direction
		emit_signal("interrupt_state", self)
	else:
		emit_signal("interrupt_state", dead_state)
		playback.travel("death")
