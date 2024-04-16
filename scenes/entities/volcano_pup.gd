extends CharacterBody2D

@onready var direction = Vector2.LEFT 
@onready var animation_tree := $AnimationTree
@onready var state_machine := $PlayerStateMachine
@export var hit_state : State

var speed = 25
var locked_on = null
var player_pos = Vector2()

const BulletPath = preload("res://scenes/entities/fireball.tscn")

func _ready():
	animation_tree.active = true
	velocity.y = 10

func _physics_process(delta):
	print(player_pos)
	#$Sprite2D.scale.x = -sign(direction.x)
	#if locked_on == true:
		#position += (Player.position - position)/speed
	
	#print(self.position)
	for i in range(5):
		var rand_num = randi_range(100, 500)
		var pos_1 = self.position.x + rand_num
		#shoot()
		

#func get_pup_position(se)
func _on_detection_area_body_entered(Player):
	locked_on = true
	print("Player Entered")
	player_pos = Player.position
	print(Player.position)


func _on_detection_area_body_exited(Player):
	locked_on = false
	print("Player Exited")


func _on_timer_timeout():
	pass # Replace with function body.


#func shoot():
	#var bullet = BulletPath.instance()
	#get_parent().add_child(bullet)
	#bullet.position = $Marker2D.global_position


func _on_detection_area_area_entered(area):
	#locked_on = true
	#player_pos = Player.position
	print("area entered")
	



func _on_detection_area_area_exited(area):
	#locked_on = false
	print("area exited")
