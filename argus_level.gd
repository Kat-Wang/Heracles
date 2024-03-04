extends Node2D

@onready var bgm := $AudioStreamPlayer2D

var player_camera: Camera2D

# Called when the node enters the scene tree for the first time.
func _ready():
	# play background music
	bgm.play()
	
	# disable player camera for boss room
	#player_camera = $Player/Camera2D
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
