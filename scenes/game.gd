extends Node2D

@onready var resting_level_path = preload("res://scenes/levels/resting_level.tscn")
@onready var hell_resting_level_path = preload("res://scenes/levels/hell_resting_level.tscn")
@onready var pre_argus_resting_level_path = preload("res://scenes/levels/pre_argus_resting_room.tscn")
@onready var player_path = preload("res://scenes/entities/player.tscn")

@onready var player := $Player.get_child(0)
@onready var health_bar := $HUD/HealthBar
@onready var coin_counter := $HUD/CoinCounter/Label
@onready var wreath_counter := $HUD/WreathCounter/Label
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
	wreath_counter.text= "0"
	player.coin_collected.connect(update_coin_count)
	player.wreath_collected.connect(update_wreath_count)
	gos.retry.connect(retry)
	$HUD/WreathCounter.visible = false
		
func instantiate_player():
	var player_instance = player_path.instantiate()
	$Player.add_child(player_instance)
	player = $Player.get_child(0)
	player.healthChanged.connect(health_bar.updatePoms)
	player.coin_count = int(coin_counter.text)
	player.heal(true)
	player.player_death.connect(game_over)
	player.coin_collected.connect(update_coin_count)
	player.wreath_collected.connect(update_wreath_count)
	
func load_checkpoint(id):
	instantiate_player()
	
	if id == 1:
		print("lo sientooooo")
		var resting_level = resting_level_path.instantiate()
		# Discarding old level
		var old_level = current_level.get_child(0)
		old_level.queue_free()

		# Adding new level
		current_level.add_child(resting_level)
		
		resting_level.connect("level_complete", transition)
		
		player.position = resting_level.starting_position.position

		gos.visible = false
	elif id == 2:
		var hell_resting_level = hell_resting_level_path.instantiate()
		# Discarding old level
		var old_level = current_level.get_child(0)
		old_level.queue_free()

		# Adding new level
		current_level.add_child(hell_resting_level)
		
		hell_resting_level.connect("level_complete", transition)
		
		player.position = hell_resting_level.starting_position.position

		gos.visible = false
	else:
		print("loading pre argus resting")
		var pre_argus_resting_level = pre_argus_resting_level_path.instantiate()
		# Discarding old level
		var old_level = current_level.get_child(0)
		old_level.queue_free()

		# Adding new level
		current_level.add_child(pre_argus_resting_level)
		
		pre_argus_resting_level.connect("level_complete", transition)
		
		player.position = pre_argus_resting_level.starting_position.position

		gos.visible = false

func transition(next_level:PackedScene):	
	print("transitioning")
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
			$HUD.visible = true
			$HUD/WreathCounter.visible = true
		elif scene_instance is RestingLevel:
			scene_instance.statue.save_checkpoint.connect(save_checkpoint)
			$HUD.visible = true
			$HUD/WreathCounter.visible = false
			player.is_in_cutscene = false
			player.camera.enabled = true
		elif scene_instance is Cutscene:
			$HUD.visible = false
			player.is_in_cutscene = true
			player.camera.enabled = false
			if scene_instance is PreHera:
				scene_instance.set_coins(int(coin_counter.text))
		else:
			$HUD.visible = true
			$HUD/WreathCounter.visible = false
			player.is_in_cutscene = false
			player.camera.enabled = true
		
		#
		#print("Player: ", player.position)
		#print("Player Global: ", player.global_position)
		#print("Camera: ", player.camera.position)
		#print("Camera Global: ", player.camera.global_position)
	else:
		game_over()

func game_over():
	gos.visible = true
	player.current_health = 0
	player.healthChanged.emit(player.current_health, false)
	player.damagable.hit(500, Vector2.RIGHT)
	
	#special cases
	var current_level_scene = current_level.get_child(0)
	
	if current_level_scene is ChallengeRoom:
		current_level_scene.victory_label.visible_ratio = 0
	if current_level_scene is HeraLevel:
		current_level_scene.victory_label.visible_ratio = 0

func update_coin_count():
	coin_counter.text = str(player.coin_count)

func update_wreath_count():
	wreath_counter.text = str(player.wreath_count)
	
func save_checkpoint(id):
	checkpoint = id

func retry():
	if checkpoint == 0:
		get_tree().reload_current_scene()
	if checkpoint == 1:
		print("loading checkpoint 1")
		load_checkpoint(1)
	if checkpoint == 2:
		load_checkpoint(2)
	if checkpoint == 3:
		load_checkpoint(3)
