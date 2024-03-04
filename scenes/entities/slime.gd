extends CharacterBody2D

const SPEED = 150

@onready var direction = Vector2.LEFT

@onready var ledgeCheckRight := $LedgeCheckRight
@onready var ledgeCheckLeft := $LedgeCheckLeft
@onready var animation_tree := $AnimationTree
@onready var state_machine := $PlayerStateMachine

@export var hit_state : State

func _ready():
	animation_tree.active = true
	velocity.y = 10
	
func _physics_process(delta):
	#var found_wall = is_on_wall()
	var left_ledge_detected = not ledgeCheckLeft.is_colliding() 
	var right_ledge_detected = not ledgeCheckRight.is_colliding()
	
	if left_ledge_detected:
		direction.x = 1
	elif right_ledge_detected:
		direction.x = -1

	$Sprite2D.scale.x = -sign(direction.x)
	
	if state_machine.check_if_can_move():
		velocity.x = direction.x * SPEED
	elif state_machine.current_state != hit_state:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	move_and_slide()
