extends CharacterBody2D

@onready var state_machine := $PlayerStateMachine
@onready var animation_tree := $AnimationTree
@onready var attack_sfx := $SFX/Attack
@onready var jump_sfx := $SFX/Jump
@onready var land_sfx := $SFX/Land

const SPEED = 500.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	animation_tree.active = true


func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
		velocity.y = min(velocity.y, 980)

		
	var direction = Input.get_vector("left", "right", "up", "down")
	
	if direction.x != 0 && state_machine.check_if_can_move():
		velocity.x = direction.x * SPEED
		$Sprite2D.scale.x = sign(direction.x) 
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	move_and_slide()
	update_animation_parameters(direction)

func update_animation_parameters(direction):
	#Sets idling or walking
	animation_tree.set("parameters/move/blend_position", direction.x)
