extends Level

class_name RestingLevel

signal level_complete(next_level:PackedScene)

@onready var statue := $Statue
@onready var resting_portal := $RestingPortal

# Called when the node enters the scene tree for the first time.
func _ready():
	resting_portal.portal_entered.connect(transition)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
		
func transition():
	level_complete.emit(next_level)
