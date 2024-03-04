extends CharacterBody2D

signal laser_shot(laser_scene, location)
@onready var laser_container = $laser_container

@onready var muzzle = $Muzzle

# chat gpt helped me with the timer to delay the laser
var timer: float = 0.0
var interval: float = 1.0

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var laser_scene = preload("res://scenes/laser_eyes.tscn")

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _process(delta):
	timer += delta
	if timer >= interval:
		timer = 0.0
		shoot()


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		
	move_and_slide()
	
func shoot():
	laser_shot.emit(laser_scene, muzzle.global_position)
	print(muzzle.global_position)

func _on_laser_shot(laser_scene, location):
	var laser = laser_scene.instantiate()
	#hardcoding location for now -- *FIX ME*
	location.x = 970.0
	location.y = 540.0
	laser.global_position = location
	laser_container.add_child(laser)
