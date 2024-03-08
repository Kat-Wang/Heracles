extends Panel


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
	
func update(whole: bool):
	if whole:
		$Sprite2D.frame = 0
	else:
		$Sprite2D.frame = 1
