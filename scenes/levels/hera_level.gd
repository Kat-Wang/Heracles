extends Level

signal level_complete(next_level:PackedScene)

@onready var bgm := $AudioStreamPlayer2D
@onready var hera := $Hera
@onready var hera_portal := $Portal

# Called when the node enters the scene tree for the first time.
func _ready():
	bgm.play()
	hera_portal.portal_entered.connect(transition)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not hera:
		$Portal.visible = true

func transition():
	level_complete.emit(next_level)
