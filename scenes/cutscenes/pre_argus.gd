extends Level

class_name Cutscene

@onready var cutscene := $Cutscene

# Called when the node enters the scene tree for the first time.
func _ready():
	cutscene.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

