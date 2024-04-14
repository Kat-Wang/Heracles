extends Level

class_name Cutscene

signal level_complete(next_level:PackedScene)

@onready var anim_player := $AnimationPlayer
@onready var bgm := $AudioStreamPlayer2D
@onready var cutscene := $Cutscene
@onready var bag := $Cutscene/BagBackground

# Called when the node enters the scene tree for the first time.
func _ready():
	anim_player.play("pre_argus")
	bgm.play()


	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func transition():
	level_complete.emit(next_level)


func _on_skip_pressed():
	transition()
