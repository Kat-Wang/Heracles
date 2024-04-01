extends Level

signal level_complete(next_level:PackedScene)

@onready var bgm := $AudioStreamPlayer2D
@onready var hell_portal := $HellPortal

func _ready():
	bgm.play()
	hell_portal.portal_entered.connect(transition)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func transition():
	level_complete.emit(next_level)
