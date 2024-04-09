extends CharacterBody2D

class_name Hera

signal healthChanged(current_health: int, healing: bool)
signal player_death
signal coin_collected

@onready var direction = Vector2.RIGHT
@onready var last_direction = 1
@onready var state_machine := $PlayerStateMachine
@onready var animation_tree := $AnimationTree
@onready var attack_sfx := $SFX/Attack
@onready var jump_sfx := $SFX/Jump
@onready var land_sfx := $SFX/Land
@onready var damagable := $Damageable

@export var max_health : int = 3
@export var damage : int = 1
@export var hit_state : State

const SPEED = 500

var current_health : int = 3
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	animation_tree.active = true
	damagable.health = max_health

func _physics_process(delta):	
	move_and_slide()
	
func is_near_wall():
	return $Sprite2D/WallChecker.is_colliding() or $Sprite2D/WallChecker2.is_colliding()

#dmg to others
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

#dmg to self
func _on_hurt_box_body_entered(body):
	var direction_to_enemy = (body.global_position - $Sprite2D/HurtBox.global_position)
	
	var direction_sign = sign(direction_to_enemy.x)
			
	if(direction_sign > 0):
		$Damageable.hit(damage, Vector2.LEFT)
	elif direction_sign < 0:
		$Damageable.hit(damage, Vector2.RIGHT)
	else:
		$Damageable.hit(damage, Vector2.ZERO)
	
	current_health = current_health - damage
	print("hera current health: ", current_health)
	print("hera damage taken: ", damage)
	print("hera health: ", current_health)
	
	healthChanged.emit(current_health, false)

func _on_hurt_box_area_entered(area):
	$Damageable.hit(damage, Vector2.LEFT)
	current_health = current_health - damage
	healthChanged.emit(current_health, false)
