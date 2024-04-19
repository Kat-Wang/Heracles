extends Node2D

@onready var resting_level_path = preload("res://scenes/levels/resting_level.tscn")
@onready var hell_resting_level_path = preload("res://scenes/levels/hell_resting_level.tscn")
@onready var player_path = preload("res://scenes/entities/player.tscn")

@onready var player := $Player.get_child(0)
@onready var health_bar := $HUD/HealthBar
@onready var coin_counter := $HUD/CoinCounter/Label
@onready var current_level := $CurrentLevel
@onready var gos := $HUD/GameOver
@onready var checkpoint = 0
#resting_level_instance = res

# Called when the node enters the scene tree for the first time.
func _ready():
	health_bar.setMaxPoms(player.max_health)
	player.healthChanged.connect(health_bar.updatePoms)
	current_level.get_child(0).level_complete.connect(transition)
	player.position = current_level.get_child(0).starting_position.position
	player.player_death.connect(game_over)
	coin_counter.text = "0"
	player.coin_collected.connect(update_coin_count)
	gos.retry.connect(retry)
		
func instantiate_player():
	var player_instance = player_path.instantiate()
	$Player.add_child(player_instance)
	player = $Player.get_child(0)
	player.healthChanged.connect(health_bar.updatePoms)
	player.coin_count = int(coin_counter.text)
	player.heal(true)
	player.player_death.connect(game_over)
	player.coin_collected.connect(update_coin_count)
	
func load_checkpoint(id):
	instantiate_player()
	
	if id == 1:
		var resting_level = resting_level_path.instantiate()
		# Discarding old level
		var old_level = current_level.get_child(0)
		old_level.queue_free()

		# Adding new level
		current_level.add_child(resting_level)
		
		resting_level.connect("level_complete", transition)
		
		player.position = resting_level.starting_position.position

		gos.visible = false
	else:
		var hell_resting_level = hell_resting_level_path.instantiate()
		# Discarding old level
		var old_level = current_level.get_child(0)
		old_level.queue_free()

		# Adding new level
		current_level.add_child(hell_resting_level)
		
		hell_resting_level.connect("level_complete", transition)
		
		player.position = hell_resting_level.starting_position.position

		gos.visible = false

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
		scene_instance.connect("level_complete", transition)
		
		player.position = scene_instance.starting_position.position
		
		if scene_instance is ChallengeRoom:
			scene_instance.timeout.connect(game_over)
		if scene_instance is RestingLevel:
			scene_instance.statue.save_checkpoint.connect(save_checkpoint)
		if scene_instance is Cutscene:
			player.is_in_cutscene = true
			player.camera.enabled = false
			if scene_instance is PreHera:
				scene_instance.set_coins(int(coin_counter.text))
		else:
			player.is_in_cutscene = false
			player.camera.enabled = true
		
		
		print("Player: ", player.position)
		print("Player Global: ", player.global_position)
		print("Camera: ", player.camera.position)
		print("Camera Global: ", player.camera.global_position)
	else:
		game_over()

func game_over():
	gos.visible = true

func update_coin_count():
	coin_counter.text = str(player.coin_count)
	
func save_checkpoint(id):
	checkpoint = id

func retry():
	if checkpoint == 0:
		get_tree().reload_current_scene()
	if checkpoint == 1:
		load_checkpoint(1)
	if checkpoint == 2:
		load_checkpoint(2)
