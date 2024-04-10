extends RigidBody2D
signal hit


func _ready():
	var mob_types = $AnimatedSprite2D.sprite_frames.get_animation_names()
	$AnimatedSprite2D.play(mob_types[randi() % mob_types.size()])

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

func _on_body_entered(body):
	print("lavaa body entrerd")
	if body is Player:
		body.current_health -= body.damage
		body.damageable.hit(body.damage, Vector2.LEFT)
		body.healthChanged.emit(body.current_health, false)



func _on_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	print("lavaa body SHAPE entrerd")
	if body is Player:
		body.current_health -= body.damage
		body.damageable.hit(body.damage, Vector2.LEFT)
		body.healthChanged.emit(body.current_health, false)
