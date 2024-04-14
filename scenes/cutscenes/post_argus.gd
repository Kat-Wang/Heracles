extends Cutscene

signal level_complete(next_level:PackedScene)

@onready var anim_player := $AnimationPlayer
@onready var bgm := $AudioStreamPlayer2D

func _ready():
	anim_player.play("post_argus")
	bgm.play()
	
func transition():
	level_complete.emit(next_level)

func _on_skip_pressed():
	transition()
