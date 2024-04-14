extends Cutscene

signal level_complete(next_level:PackedScene)

@onready var anim_player := $AnimationPlayer
@onready var bgm := $AudioStreamPlayer2D
@onready var cutscene := $Cutscene
@onready var bag := $Cutscene/BagBackground

func _ready():
	anim_player.play("pre_argus")
	bgm.play()

func _process(delta):
	pass

func transition():
	level_complete.emit(next_level)

func _on_skip_pressed():
	transition()
