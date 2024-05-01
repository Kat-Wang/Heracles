extends Area2D

class_name Coin

@onready var sprite := $AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.play()

func collected():
	queue_free()
