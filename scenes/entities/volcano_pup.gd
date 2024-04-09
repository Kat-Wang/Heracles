extends CharacterBody2D

@onready var direction = Vector2.LEFT 
@onready var animation_tree := $AnimationTree
@onready var state_machine := $PlayerStateMachine
@export var hit_state : State

var speed = 25
var locked_on = null
var player_pos = Vector2()

func _ready():
	animation_tree.active = true
	velocity.y = 10

func _physics_process(delta):
	$Sprite2D.scale.x = -sign(direction.x)
	#if locked_on == true:
		#position += (Player.position - position)/speed
		#print(player_pos)

func _on_detection_area_body_entered(Player):
	locked_on = true
	player_pos = Player.position
	print(Player.position)


func _on_detection_area_body_exited(Player):
	locked_on = false


func _on_timer_timeout():
	pass # Replace with function body.
