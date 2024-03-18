extends Node

# Bacon and Games on YouTube: https://www.youtube.com/watch?v=2uYaoQj_6o0

const LEVEL_H:int = 144
const LEVEL_W:int = 240

signal content_finished_loading(content)
signal zelda_content_finished_loading(content)
signal content_invalid(content_path:String)
signal content_failed_to_load(content_path:String)

var loading_screen:LoadingScreen
var _loading_screen_scene:PackedScene = preload("res://scenes/ui/loading_screen.tscn")
var _transition:String
var _content_path:String
var _load_progress_timer:Timer



func _ready() -> void:
	content_invalid.connect(on_content_invalid)
	content_failed_to_load.connect(on_content_failed_to_load)
	content_finished_loading.connect(on_content_finished_loading)
	print("SceneManager children count:", self.get_child_count())
	print(self.get_children())

func load_new_scene(content_path:String, transition_type:String="fade_to_black") -> void:
	_transition = transition_type
	# add loading screen
	loading_screen = _loading_screen_scene.instantiate() as LoadingScreen
	get_tree().root.add_child(loading_screen)
	loading_screen.start_transition(transition_type)
	_load_content(content_path)
	
func _load_content(content_path:String) -> void:
	
	# zelda transition doesn't use a loading screen - personal preference
	if loading_screen != null:
		await loading_screen.transition_in_complete
		
	_content_path = content_path
	var loader = ResourceLoader.load_threaded_request(content_path)
	if not ResourceLoader.exists(content_path) or loader == null:
		content_invalid.emit(content_path)
		return 		
	
	_load_progress_timer = Timer.new()
	_load_progress_timer.wait_time = 0.1
	_load_progress_timer.timeout.connect(monitor_load_status)
	get_tree().root.add_child(_load_progress_timer)
	_load_progress_timer.start()

# checks in on loading status - this can also be done with a while loop, but I found that ran too fast
# and ended up skipping over the loading display. 
func monitor_load_status() -> void:
	var load_progress = []
	var load_status = ResourceLoader.load_threaded_get_status(_content_path, load_progress)

	match load_status:
		ResourceLoader.THREAD_LOAD_INVALID_RESOURCE:
			content_invalid.emit(_content_path)
			_load_progress_timer.stop()
			return
		ResourceLoader.THREAD_LOAD_IN_PROGRESS:
			if loading_screen != null:
				loading_screen.update_bar(load_progress[0] * 100) # 0.1
		ResourceLoader.THREAD_LOAD_FAILED:
			content_failed_to_load.emit(_content_path)
			_load_progress_timer.stop()
			return
		ResourceLoader.THREAD_LOAD_LOADED:
			_load_progress_timer.stop()
			_load_progress_timer.queue_free()
			content_finished_loading.emit(ResourceLoader.load_threaded_get(_content_path).instantiate())
			return 

func on_content_failed_to_load(path:String) -> void:
	printerr("error: Failed to load resource: '%s'" % [path])	

func on_content_invalid(path:String) -> void:
	printerr("error: Cannot load resource: '%s'" % [path])
	
func on_content_finished_loading(content) -> void:
	print("SceneManager children count:", self.get_child_count())
	var outgoing_scene = self.get_child(0)
	if outgoing_scene:
		print("Outgoing scene found:", outgoing_scene)
		outgoing_scene.queue_free()
	else:
		printerr("Error: Outgoing scene is null")
	
	# Add and set the new scene to current
	self.call_deferred("add_child",content)
	self.set_deferred("current_scene",content)
	
	# probably not necssary since we split our content_finished_loading but it won't hurt to have an extra check
	if loading_screen != null:
		loading_screen.finish_transition()
		# e.g. will be skipped if we're loading a menu instead of a game level
		if content is Level:
			content.init_player_location()
		# wait for LoadingScreen's transition to finish playing
		await loading_screen.anim_player.animation_finished
		loading_screen = null
		# samesies^
		if content is Level:
			content.enter_level()
