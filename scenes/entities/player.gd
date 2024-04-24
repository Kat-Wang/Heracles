extends CharacterBody2D

class_name Player

signal healthChanged(current_health: int, healing: bool)
signal player_death
signal coin_collected
signal wreath_collected

@onready var direction = Vector2.RIGHT
@onready var last_direction = 1
@onready var state_machine := $PlayerStateMachine
@onready var animation_tree := $AnimationTree
@onready var attack_sfx := $SFX/Attack
@onready var jump_sfx := $SFX/Jump
@onready var land_sfx := $SFX/Land
@onready var sword_hitting_sceptre_sfx := $SFX/SwordHittingSceptre
@onready var coin_count : int = 0
@onready var wreath_count : int = 0
@onready var damagable := $Damageable
@onready var camera := $Camera2D

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
var default_cam_position = Vector2(0, -186)
var is_in_cutscene = false

func _ready():
	animation_tree.active = true
	damagable.health = max_health
	damagable.player_died.connect(signal_player_died)

func _physics_process(delta):
	if is_in_cutscene:
		self.visible = false
	else:
		self.visible = true
		
	if !is_in_cutscene:
		if not is_on_floor():
			velocity.y += gravity * delta
			velocity.y = min(velocity.y, 980)
			
		var direction = Input.get_vector("left", "right", "up", "down")
		
		if dash_available and Input.is_action_pressed("dash"):
			#$AnimationPlayer.play("dash")
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
	print("hurt body entered")
	var direction_to_enemy = (body.global_position - $Sprite2D/HurtBox.global_position)
	
	var direction_sign = sign(direction_to_enemy.x)
	
	current_health = current_health - damage
			
	if(direction_sign > 0):
		$Damageable.hit(damage, Vector2.LEFT)
	elif direction_sign < 0:
		$Damageable.hit(damage, Vector2.RIGHT)
	else:
		$Damageable.hit(damage, Vector2.ZERO)
	
	print("current health: ", current_health)
	print("damage taken: ", damage)
	print("player health: ", current_health)
	
	healthChanged.emit(current_health, false)

func _on_hurt_box_area_entered(area):
	print("hurt area entered")
	if area is Coin:
		coin_count += 1
		area.collected()
		coin_collected.emit()
	elif area is PomPickup:
		heal(false)
		area.collected()
	elif area is Wreath:
		wreath_count += 1
		area.collected()
		wreath_collected.emit()
	else:
		print("laval hurt")
		current_health = current_health - damage
		$Damageable.hit(damage, Vector2.LEFT)
		healthChanged.emit(current_health, false)

func signal_player_died():
	player_death.emit()

func heal(full: bool):
	if full:
		current_health = max_health
		healthChanged.emit(current_health, true)
	else:
		current_health = min(max_health, current_health + 1)
		healthChanged.emit(current_health, true)

func _on_dash_timer_timeout():
	dash_available = true

func _on_dashing_timeout():
	dashing = false

func _on_sword_hit_box_area_entered(area):
	if area is Sceptre:
		sword_hitting_sceptre_sfx.play()
		area.queue_free()
	if area is BatProjectile:
		area.queue_free()
