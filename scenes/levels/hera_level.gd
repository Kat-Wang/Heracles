extends Level

signal level_complete(next_level:PackedScene)

@onready var bgm := $AudioStreamPlayer2D
@onready var hera := $Hera

# Called when the node enters the scene tree for the first time.
func _ready():
	bgm.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not hera:
		$Portal.visible = true

