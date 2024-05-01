extends Area2D

class_name PomPickup

@onready var sprite := $AnimatedSprite2D

func _ready():
	$AnimatedSprite2D.play()
	
func collected():
	queue_free()
