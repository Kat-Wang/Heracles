extends Area2D

class_name Coin

@onready var sfx := $AudioStreamPlayer2D
@onready var sprite := $AnimatedSprite2D
@onready var timer := $Timer

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func collected():
	timer.start()
	sprite.visible = false
	sfx.play()

func _on_timer_timeout():
	queue_free()
