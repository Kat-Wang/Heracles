extends Area2D

class_name PomPickup

@onready var sfx := $AudioStreamPlayer2D
@onready var sprite := $AnimatedSprite2D
@onready var timer := $Timer

func _ready():
	$AnimatedSprite2D.play()
	
func collected():
	timer.start()
	sprite.visible = false
	sfx.play()

func _on_timer_timeout():
	queue_free()
