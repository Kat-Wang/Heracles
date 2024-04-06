extends RigidBody2D
signal hit

func _ready():
	var mob_types = $AnimatedSprite2D.sprite_frames.get_animation_names()
	$AnimatedSprite2D.play(mob_types[randi() % mob_types.size()])


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _on_body_entered(body):
	hide()
	hit.emit()
	$CollisionShape2D.set_deferred("disabled", true)
	queue_free()
