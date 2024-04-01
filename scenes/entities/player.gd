extends CharacterBody2D

class_name Player

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
@onready var coin_count : int = 0
@onready var damagable := $Damageable

@export var max_health : int = 5
@export var damage : int = 1
@export var hit_state : State
@export var wall_state : State

const SPEED = 500
const DASH_SPEED = 1500

var dash_available = true
var dashing = false
var current_health : int = 5
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	animation_tree.active = true
	damagable.health = max_health
	damagable.player_died.connect(signal_player_died)

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
		velocity.y = min(velocity.y, 980)
		
	var direction = Input.get_vector("left", "right", "up", "down")
	
	if dash_available and Input.is_action_pressed("dash"):
		velocity.x = last_direction * DASH_SPEED
		$DashCooldown.start()
		$Dashing.start()
		dash_available = false
		dashing = true
	elif direction.x != 0 && state_machine.check_if_can_move() && !dashing && state_machine.current_state != wall_state:
		velocity.x = direction.x * SPEED
		$Sprite2D.scale.x = sign(direction.x) 
		last_direction = sign(direction.x)
	elif state_machine.current_state != hit_state and !dashing:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	move_and_slide()
	update_animation_parameters(direction)

func update_animation_parameters(direction):
	#Sets idling or walking
	animation_tree.set("parameters/move/blend_position", direction.x)
	
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
	print("current health: ", current_health)
	print("damage taken: ", damage)
	print("player health: ", current_health)
	
	healthChanged.emit(current_health, false)

func _on_hurt_box_area_entered(area):
	if area is Coin:
		coin_count += 1
		area.collected()
		coin_collected.emit()
	elif area is PomPickup:
		heal(true)
		area.collected()
	elif area is Wreath:
		area.collected()
	else:
		$Damageable.hit(damage, Vector2.LEFT)
		current_health = current_health - damage
		healthChanged.emit(current_health, false)

func signal_player_died():
	player_death.emit()

func heal(full: bool):
	if full:
		current_health = max_health
		healthChanged.emit(current_health, true)
	else:
		current_health += 1

func _on_dash_timer_timeout():
	dash_available = true

func _on_dashing_timeout():
	dashing = false
