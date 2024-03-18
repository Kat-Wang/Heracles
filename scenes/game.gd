extends Node2D

@onready var player := $Player
@onready var health_bar := $HUD/HealthBar
@onready var coin_counter := $HUD/CoinCounter/Label
@onready var current_level := $CurrentLevel

# Called when the node enters the scene tree for the first time.
func _ready():
	health_bar.setMaxPoms(player.max_health)
	player.healthChanged.connect(health_bar.updatePoms)
	current_level.get_child(0).level_complete.connect(transition)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	coin_counter.text = str(player.coin_count)

func transition(next_level:PackedScene):
	print("transitioning to the next scene")
	# Instantiating next level
	var scene_instance = next_level.instantiate()

	# Discarding old level
	var old_level = current_level.get_child(0)
	old_level.queue_free()

	# Adding new level
	current_level.add_child(scene_instance)

	# Connect new level to transition function
	var new_level = current_level.get_child(0)
	scene_instance.connect("level_complete", transition)
