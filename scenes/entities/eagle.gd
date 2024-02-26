extends CharacterBody2D

const SPEED = 150

var direction = Vector2.LEFT

@onready var ledgeCheckRight := $LedgeCheckRight
@onready var ledgeCheckLeft := $LedgeCheckLeft

func _ready():
	pass
	
func _physics_process(delta):
	$AnimatedSprite2D.play("move")
	var found_wall = is_on_wall()
	var found_ledge = not ledgeCheckLeft.is_colliding() or not ledgeCheckRight.is_colliding()
	
	if found_wall or found_ledge:
		direction *= -1


	$AnimatedSprite2D.scale.x = -sign(direction.x)
	#$Hitbox.scale.x = -sign(direction.x)
	velocity = direction * SPEED
	move_and_slide()


#const SPEED = 300.0
#const JUMP_VELOCITY = -400.0
#
## Get the gravity from the project settings to be synced with RigidBody nodes.
#var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
#
#
#func _physics_process(delta):
	## Add the gravity.
	#if not is_on_floor():
		#velocity.y += gravity * delta
#
	## Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		#velocity.y = JUMP_VELOCITY
#
	## Get the input direction and handle the movement/deceleration.
	## As good practice, you should replace UI actions with custom gameplay actions.
	#var direction = Input.get_axis("ui_left", "ui_right")
	#if direction:
		#velocity.x = direction * SPEED
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)
#
	#move_and_slide()
