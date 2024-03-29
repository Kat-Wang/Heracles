extends Area2D

class_name Laser

@export var speed = 600
@export var direction = -1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	global_position.x -= speed * delta * direction
	
func _on_visible_on_screen_notifier_2d_screen_exited():
		queue_free()
