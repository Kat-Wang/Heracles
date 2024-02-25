extends CharacterBody2D

@onready var animation_tree := $AnimationTree

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

#var max_jumps = 2
#var jumps_remaining = max_jumps
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

enum STATE {READY, ATTACKING}
var state:= STATE.READY

func _ready():
	animation_tree.active = true

func _process(_delta):
	update_animation_parameters()

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	#
	#if is_on_floor():
		#jumps_remaining = max_jumps

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		#jumps_remaining -= 1
		
	#if Input.is_action_just_pressed("jump") and !is_on_floor() and jumps_remaining > 0:
		#velocity.y = JUMP_VELOCITY
		#jumps_remaining -= 1
		
	var direction = Input.get_axis("left", "right")
	
	if direction:
		velocity.x = direction * SPEED
		$Sprite2D.scale.x = sign(direction) 
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	move_and_slide()

func change_state(new_state: STATE):
	state = new_state

func attack():
	if state == STATE.ATTACKING:
		return
	
	change_state(STATE.ATTACKING)
	$AttackTimer.start()

func _on_attack_timer_timeout():
	change_state(STATE.READY)

func update_animation_parameters():
	#idling or walking
	if velocity.x == 0:
		animation_tree["parameters/conditions/idling"] = true
		animation_tree["parameters/conditions/moving"] = false
	else:
		animation_tree["parameters/conditions/idling"] = false
		animation_tree["parameters/conditions/moving"] = true
	
	#attacking or not attacking
	if state == STATE.READY && Input.is_action_just_pressed("attack"):
		animation_tree["parameters/conditions/attacking"] = true
	else:
		animation_tree["parameters/conditions/attacking"] = false

	#jumping
	if velocity.y < 0:
		animation_tree["parameters/conditions/jumping"] = true
		animation_tree["parameters/conditions/falling"] = false
		animation_tree["parameters/conditions/grounded"] = false
	if velocity.y > 0 :
		print("i should be falling here")
		animation_tree["parameters/conditions/jumping"] = false
		animation_tree["parameters/conditions/falling"] = true
		animation_tree["parameters/conditions/grounded"] = false
	if velocity.y == 0:
		animation_tree["parameters/conditions/jumping"] = false
		animation_tree["parameters/conditions/falling"] = false
		animation_tree["parameters/conditions/grounded"] = true
	
	#print(velocity.y)
	#print(animation_tree["parameters/conditions/jumping"])

