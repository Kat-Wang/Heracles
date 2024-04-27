extends Level

signal level_complete(next_level:PackedScene)

@onready var bgm := $AudioStreamPlayer2D
@onready var argus := $Argus
@onready var argus_portal := $ArgusPortal
@onready var wall := $Wall1

var wall_queued_free = false

# Called when the node enters the scene tree for the first time.
func _ready():
	bgm.play()
	argus_portal.portal_entered.connect(transition)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not argus:
		$StaticBody2D2/CollisionShape2D.disabled = true
		pass
		
func transition():
	level_complete.emit(next_level)


func _on_argus_argus_dead():
	if (!wall_queued_free):
			wall.queue_free()
			wall_queued_free = true
