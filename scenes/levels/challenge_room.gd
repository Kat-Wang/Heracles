extends Level

class_name ChallengeRoom

signal level_complete(next_level:PackedScene)
signal timeout

@onready var bgm := $BGM
@onready var challenge_portal := $ChallengePortal
@onready var countdown := $Countdown
@onready var countdown_label := $CanvasLayer/TimerLabel
@onready var intro_label := $CanvasLayer/IntroLabel
@onready var intro_timer := $CanvasLayer/IntroTimer
@onready var victory_label := $CanvasLayer/VictoryLabel
@onready var victory_sfx := $CanvasLayer/VictorySFX

@export var mob_scene: PackedScene

var score

func _ready():
	bgm.play()
	challenge_portal.portal_entered.connect(transition)
	countdown_label.visible = false
	challenge_portal.visible = false
	victory_label.visible = false
	intro_timer.start()
	
func _process(delta):
	countdown_label.text = str(round(countdown.time_left))
	
	if $Wreaths.get_child_count() == 0:
		victory_label.visible = true
		challenge_portal.visible = true
		countdown.stop()
		countdown_label.visible = false
		victory_sfx.play()

func transition():
	level_complete.emit(next_level)

func _on_mob_timer_timeout():
	var mob = mob_scene.instantiate()

	# Choose a random location on Path2D.
	var mob_spawn_location = $MobPath/MobSpawnLocation
	mob_spawn_location.progress_ratio = randf()

	# Set the mob's direction perpendicular to the path direction.
	#var direction = mob_spawn_location.rotation + PI / 2

	# Set the mob's position to a random location.
	mob.position = mob_spawn_location.position

	# Add some randomness to the direction.
	#direction += randf_range(-PI / 4, PI / 4)
	#mob.rotation = direction

	# Choose the velocity for the mob.
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	#mob.linear_velocity = velocity.rotated(direction)

	# Spawn the mob by adding it to the Main scene.
	add_child(mob)

func _on_countdown_timeout():
	timeout.emit()

func _on_intro_timer_timeout():
	countdown.start()
	countdown_label.visible = true
	intro_label.visible = false
	$MobTimer.start()
