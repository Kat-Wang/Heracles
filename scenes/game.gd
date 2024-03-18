extends Node2D

@onready var player := $Player
@onready var health_bar := $HUD/HealthBar
@onready var current_level := $CurrentLevel

# Called when the node enters the scene tree for the first time.
func _ready():
	health_bar.setMaxPoms(player.max_health)
	player.healthChanged.connect(health_bar.updatePoms)
	current_level.get_child(0).level_complete.connect(transition)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func transition(next_level:PackedScene):
	var scene_instance = next_level.instantiate()
	current_level.get_child(0).queue_free()
	current_level.add_child(scene_instance)
	
