extends CharacterBody2D

const SPEED = 150

var direction = Vector2.LEFT

@onready var ledgeCheckRight := $LedgeCheckRight
@onready var ledgeCheckLeft := $LedgeCheckLeft

func _ready():
	pass
	
func _physics_process(delta):
	#$AnimatedSprite2D.play("move")
	var found_wall = is_on_wall()
	var found_ledge = not ledgeCheckLeft.is_colliding() or not ledgeCheckRight.is_colliding()
	
	if found_wall or found_ledge:
		direction *= -1

	$Sprite2D.scale.x = -sign(direction.x)
	#$Hitbox.scale.x = -sign(direction.x)
	velocity = direction * SPEED
	move_and_slide()
