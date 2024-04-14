extends Level

class_name RestingLevel

signal level_complete(next_level:PackedScene)

@export var id: int

@onready var statue := $Statue
@onready var resting_portal := $RestingPortal
@onready var bgm := $AudioStreamPlayer2D
@onready var cat := $Cat

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
