extends Level

class_name ChallengeRoom

signal level_complete(next_level:PackedScene)
signal timeout

@onready var bgm := $AudioStreamPlayer2D
@onready var room_portal := $RoomPortal
@onready var countdown := $Countdown
@onready var countdown_label := $CanvasLayer/Label
@export var mob_scene: PackedScene

var score

# Called when the node enters the scene tree for the first time.
func _ready():
	bgm.play()
	room_portal.portal_entered.connect(transition)
	countdown.start()
#	_on_mob_timer_timeout()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	countdown_label.text = str(round(countdown.time_left))

func transition():
	level_complete.emit(next_level)

func _on_mob_timer_timeout():
	var mob = mob_scene.instantiate()

	# Choose a random location on Path2D.
	var mob_spawn_location = $MobPath/MobSpawnLocation
	mob_spawn_location.progress_ratio = randf()

	# Set the mob's direction perpendicular to the path direction.
	var direction = mob_spawn_location.rotation + PI / 2

	# Set the mob's position to a random location.
	mob.position = mob_spawn_location.position

	# Add some randomness to the direction.
	direction += randf_range(-PI / 4, PI / 4)
	mob.rotation = direction

	# Choose the velocity for the mob.
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	mob.linear_velocity = velocity.rotated(direction)

	# Spawn the mob by adding it to the Main scene.
	add_child(mob)



func _on_countdown_timeout():
	timeout.emit()
