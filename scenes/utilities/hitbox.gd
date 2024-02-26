extends Area2D

func _on_body_entered(body):
	if body.is_class("player"):
		print("enemy hit")

