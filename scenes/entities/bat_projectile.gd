extends Area2D

class_name BatProjectile

@export var speed = 350


func _ready():
	pass

func _process(delta):
	global_position.y += speed * delta

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

func _on_body_entered(body):
	queue_free()
