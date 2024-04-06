extends HitState

func on_damageable_hit(node : Node, damage_amount : int, knockback_direction : Vector2):
	if damageable.health > 0:
		character.velocity = knockback_speed * knockback_direction
		emit_signal("interrupt_state", self)
		playback.travel("hit")
	else:
		emit_signal("interrupt_state", dead_state)
		print("player should die")
		playback.travel("death")
		
