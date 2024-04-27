extends Area2D

class_name Wreath

signal wreath_collected

@onready var sfx := $AudioStreamPlayer2D
@onready var sprite := $AnimatedSprite2D
@onready var collision := $CollisionShape2D
@onready var timer := $Timer

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.play()
	
func collected():
	wreath_collected.emit()
	queue_free()
