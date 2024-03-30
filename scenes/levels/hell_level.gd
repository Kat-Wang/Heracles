extends Level

signal level_complete(next_level:PackedScene)

@onready var bgm := $AudioStreamPlayer2D
@onready var hell_portal := $HellPortal
@export var mob_scene: PackedScene

var score

# Called when the node enters the scene tree for the first time.
func _ready():
	bgm.play()
	hell_portal.portal_entered.connect(transition)
	_on_mob_timer_timeout()
	
	

	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func transition():
	level_complete.emit(next_level)

func _on_mob_timer_timeout():
	var mob = mob_scene.instantiate()
	print("drop")
	
	var screen_width = get_viewport_rect().size.x
	var random_x_position = randf_range(0, screen_width)
	var spawn_height = get_viewport_rect().size.y * -0.1
	mob.position = Vector2(random_x_position, spawn_height)
	
	add_child(mob)
