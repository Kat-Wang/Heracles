extends CharacterBody2D

#signal laser_shot(laser_scene, location)

@onready var direction = Vector2.LEFT 
@onready var laser_container = $LaserContainer
@onready var muzzle = $Muzzle
@onready var animation_tree := $AnimationTree
@onready var state_machine := $PlayerStateMachine

@export var hit_state : State

# chat gpt helped me with the timer to delay the laser
var timer: float = 0.0
var interval: float = 1.0

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var laser_scene = preload("res://scenes/entities/laser_eyes.tscn")
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	animation_tree.active = true

func _process(delta):
	timer += delta
	if timer >= interval:
		timer = 0.0
		shoot(laser_scene)
		print("argus shooting")

func _physics_process(delta):
	# Add the gravity.
	#if not is_on_floor():
		#velocity.y += gravity * delta
	var found_wall = is_on_wall()
	
	if found_wall:
		direction.x *= -1

	$Sprite2D.scale.x = -sign(direction.x)
		
	if state_machine.check_if_can_move():
		velocity.x = direction.x * SPEED
	elif state_machine.current_state != hit_state:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	move_and_slide()
	
#func shoot():
	#laser_shot.emit(laser_scene, muzzle.global_position)
	#print(muzzle.global_position)

func shoot(laser_scene):
	var laser = laser_scene.instantiate()
	#hardcoding location for now -- *FIX ME*
	#location.x = 970.0
	#location.y = 540.0
	laser.global_position = $Muzzle.global_position
	print("laser position: ", laser.global_position)
	$Muzzle.add_child(laser)

