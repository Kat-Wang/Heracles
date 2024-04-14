extends Cutscene

signal level_complete(next_level:PackedScene)

@onready var anim_player := $AnimationPlayer
@onready var bgm := $AudioStreamPlayer2D
@onready var cutscene := $Cutscene

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
