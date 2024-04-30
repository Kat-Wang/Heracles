extends Cutscene

signal level_complete(next_level:PackedScene)

@onready var anim_player := $AnimationPlayer
@onready var bgm := $BGM
@onready var cutscene := $Cutscene

func _ready():
	anim_player.play("post_hera")
	bgm.play()

func _process(delta):
	pass

func transition():
	level_complete.emit(next_level)

func _on_audio_stream_player_2d_finished():
	transition()

