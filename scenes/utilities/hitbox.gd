extends Area2D


func _on_body_entered(body):
	print("enemy hitbox was entered")
	if body.is_class("Player"):
		get_tree().reload_current_scene_override()

