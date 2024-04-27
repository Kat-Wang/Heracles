extends CharacterBody2D

const SPEED = 150

@onready var direction = Vector2.LEFT

@onready var projectile_container = $ProjectileContainer
@onready var muzzle_1 = $Muzzle1
@onready var muzzle_2 = $Muzzle2
@onready var muzzle_3 = $Muzzle3
@onready var muzzle_4 = $Muzzle4
@onready var muzzle_5 = $Muzzle5
var bat_projectile = preload("res://scenes/entities/bat_projectile.tscn")

@onready var animation_tree := $AnimationTree
@onready var state_machine := $PlayerStateMachine

@export var hit_state : State

# chat gpt helped me with the timer to delay the laser
@export var timer: float = 1.8
var interval: float = 1.25

func _ready():
	animation_tree.active = true
	
func _process(delta):
	timer += delta
	if timer >= interval:
		timer = 0.0
		shoot()
	
func _physics_process(delta):
	pass

func shoot():
	var projectile_1 = bat_projectile.instantiate()
	var projectile_2 = bat_projectile.instantiate()
	var projectile_3 = bat_projectile.instantiate()
	#var projectile_4 = bat_projectile.instantiate()
	#var projectile_5 = bat_projectile.instantiate()

	projectile_container.add_child(projectile_1)
	projectile_1.global_position = muzzle_1.global_position
	projectile_container.add_child(projectile_2)
	projectile_2.global_position = muzzle_2.global_position
	projectile_container.add_child(projectile_3)
	projectile_3.global_position = muzzle_3.global_position
	#projectile_container.add_child(projectile_4)
	#projectile_4.global_position = muzzle_4.global_position
	#projectile_container.add_child(projectile_5)
	#projectile_5.global_position = muzzle_5.global_position
