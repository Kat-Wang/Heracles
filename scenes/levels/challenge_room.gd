extends Level

class_name ChallengeRoom

signal level_complete(next_level:PackedScene)
signal timeout

@onready var bgm := $BGM
@onready var wreath_sfx := $WreathSFX
@onready var challenge_portal := $ChallengePortal
@onready var countdown := $Countdown
@onready var countdown_label := $CanvasLayer/TimerLabel
@onready var intro_label := $CanvasLayer/IntroLabel
@onready var intro_timer := $CanvasLayer/IntroTimer
@onready var victory_label := $CanvasLayer/VictoryLabel
@onready var victory_sfx := $CanvasLayer/VictorySFX
@onready var victory_label_toggle = false

@export var mob_scene: PackedScene

var score

func _ready():
	bgm.play()
	challenge_portal.portal_entered.connect(transition)
	countdown_label.visible = false
	challenge_portal.visible = false
	challenge_portal.monitoring = false
	victory_label.visible = false
	intro_timer.start()
	for wreath in $Wreaths.get_children():
		wreath.wreath_collected.connect(play_wreath_sfx)
		print("connecting")
	
func _process(delta):
	countdown_label.text = str(round(countdown.time_left))
	
	if $Wreaths.get_child_count() == 0:
		victory_label.visible = true
		challenge_portal.visible = true
		challenge_portal.monitoring = true
		countdown.stop()
		countdown_label.visible = false
		victory_sfx.play()

func transition():
	level_complete.emit(next_level)

func _on_mob_timer_timeout():
	var mob = mob_scene.instantiate()

	var mob_spawn_location = $MobPath/MobSpawnLocation
	mob_spawn_location.progress_ratio = randf()
	
	mob.position = mob_spawn_location.position
	
	#var velocity = Vector2(radndf_range(150.0, 250.0), 0.0)
	
	add_child(mob)

func _on_countdown_timeout():
	timeout.emit()

func _on_intro_timer_timeout():
	countdown.start()
	countdown_label.visible = true
	intro_label.visible = false
	$MobTimer.start()
	
func play_wreath_sfx():
	wreath_sfx.play()
	print("playing sfx")
