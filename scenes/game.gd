extends Node2D

#var sky_level = preload("res://scenes/levels/sky_level.tscn")

@onready var player := $Player
@onready var health_bar := $HUD/HealthBar
@onready var coin_counter := $HUD/CoinCounter/Label
@onready var current_level := $CurrentLevel
@onready var gos := $HUD/GameOver
#@onready var checkpoint = sky_level.instantiate()

# Called when the node enters the scene tree for the first time.
func _ready():
	health_bar.setMaxPoms(player.max_health)
	player.healthChanged.connect(health_bar.updatePoms)
	current_level.get_child(0).level_complete.connect(transition)
	player.position = current_level.get_child(0).starting_position.position
	player.player_death.connect(game_over)
	coin_counter.text = "0"
	player.coin_collected.connect(update_coin_count)
	#gos.load_checkpoint.connect(load_checkpoint)
	#
#func load_checkpoint():
#
	## Instantiating next level
	#var scene_instance = next_level.instantiate()
#
	## Discarding old level
	#var old_level = current_level.get_child(0)
	#old_level.queue_free()
#
	## Adding new level
	#current_level.add_child(scene_instance)
#
	## Connect new level to transition function
	#var new_level = current_level.get_child(0)
	#scene_instance.connect("level_complete", transition)
	#
	#player.position = scene_instance.starting_position.position
	#
	#checkpoint = scene_instance
	#gos.checkpoint = scene_instance
	#print(checkpoint)
	#
	#if scene_instance is ChallengeRoom:
		#scene_instance.timeout.connect(game_over)
	#if scene_instance is RestingLevel:
		#scene_instance.statue.save_checkpoint.connect(save_checkpoint())

	
func transition(next_level:PackedScene):
	if next_level:
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
		
		player.position = scene_instance.starting_position.position
		
		#checkpoint = scene_instance
		#gos.checkpoint = scene_instance
		#print(checkpoint)
		
		if scene_instance is ChallengeRoom:
			scene_instance.timeout.connect(game_over)
		#if scene_instance is RestingLevel:
			#scene_instance.statue.save_checkpoint.connect(save_checkpoint())
	else:
		game_over()

func game_over():
	gos.visible = true

func update_coin_count():
	coin_counter.text = str(player.coin_count)
	
#func save_checkpoint():
	#checkpoint = current_level.get_child(0)
