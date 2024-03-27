extends CharacterBody2D

#signal laser_shot(laser_scene, location)

@onready var direction = Vector2.LEFT 
@onready var laser_container = $LaserContainer
<<<<<<< Updated upstream
@onready var muzzle = $Muzzle
=======
@onready var muzzle_1 = $Sprite2D/Muzzle1
@onready var muzzle_2 = $Sprite2D/Muzzle2
@onready var muzzle_3 = $Sprite2D/Muzzle3
@onready var muzzle_idx = 0
>>>>>>> Stashed changes
@onready var animation_tree := $AnimationTree
@onready var state_machine := $PlayerStateMachine

@onready var muzzle_array = [muzzle_1, muzzle_2, muzzle_3]

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

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		velocity.y = min(velocity.y, 980)

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
<<<<<<< Updated upstream
	#hardcoding location for now -- *FIX ME*
	#location.x = 970.0
	#location.y = 540.0
	laser.global_position = $Muzzle.global_position
	$Muzzle.add_child(laser)

=======
	laser.direction = laser_direction
	laser.position = muzzle_array[muzzle_idx].position
	laser_container.add_child(laser)
	muzzle_idx = randi_range(0, muzzle_array.size() - 1)
>>>>>>> Stashed changes
