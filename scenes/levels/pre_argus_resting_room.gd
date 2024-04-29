extends RestingLevel


# Called when the node enters the scene tree for the first time.
func _ready():
	resting_portal.portal_entered.connect(transition)
	bgm.play()
	cat.play()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
		
func transition():
	level_complete.emit(next_level)
