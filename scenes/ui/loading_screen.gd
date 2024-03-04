extends CanvasLayer

class_name LoadingScreen

@onready var progress_bar := $ProgressBar
@onready var anim_player := $AnimationPlayer
@onready var timer := $Timer

func _ready():
	progress_bar.visible = false

