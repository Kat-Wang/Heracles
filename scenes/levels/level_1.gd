extends Node2D

@onready var bgm := $AudioStreamPlayer2D

# Called when the node enters the scene tree for the first time.
func _ready():
	bgm.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
