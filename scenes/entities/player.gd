extends CharacterBody2D

class_name Player

@onready var direction = Vector2.LEFT
@onready var state_machine := $PlayerStateMachine
@onready var animation_tree := $AnimationTree
@onready var attack_sfx := $SFX/Attack
@onready var jump_sfx := $SFX/Jump
@onready var land_sfx := $SFX/Land

@export var damage : int = 1
@export var hit_state : State

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
	elif state_machine.current_state != hit_state:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	move_and_slide()
	update_animation_parameters(direction)

func update_animation_parameters(direction):
	#Sets idling or walking
	animation_tree.set("parameters/move/blend_position", direction.x)

func _on_sword_hit_box_body_entered(body):
	for child in body.get_children():
		if child is Damageable:
			var direction_to_damageable = (body.global_position - $Sprite2D/SwordHitBox.global_position)
		
			var direction_sign = sign(direction_to_damageable.x)
			
			if(direction_sign > 0):
				child.hit(damage, Vector2.RIGHT)
			elif direction_sign < 0:
				child.hit(damage, Vector2.LEFT)
			else:
				child.hit(damage, Vector2.ZERO)

func _on_hurt_box_body_entered(body):
	print("Player body entered")
	
	var direction_to_enemy = (body.global_position - $Sprite2D/HurtBox.global_position)
	
	var direction_sign = sign(direction_to_enemy.x)
			
	if(direction_sign > 0):
		$Damageable.hit(damage, Vector2.LEFT)
	elif direction_sign < 0:
		$Damageable.hit(damage, Vector2.RIGHT)
	else:
		$Damageable.hit(damage, Vector2.ZERO)
	


func _on_hurt_box_area_entered(area):
	print("Player area entered")
	$Damageable.hit(5, Vector2.LEFT)
