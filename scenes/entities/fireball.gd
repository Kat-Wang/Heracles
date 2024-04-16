extends CharacterBody2D

const GRAVITY = 1000
var VELOCITY = Vector2.ZERO
#var SPEED = 300

func _physics_process(delta):
	velocity.y += GRAVITY *delta
	move_and_collide(VELOCITY * delta)
	#var collision_info = move_and_collide(VELOCITY.normalized()*delta*SPEED)
	
func projectile_arc_cacluation(source_position, target_position, arc_height, gravity):
	var velocity = Vector2()
	var displacement = target_position - source_position
	
	if displacement.y > arc_height:
		var time_up = sqrt(-2 * arc_height/float(gravity))
		var time_down = sqrt(2* (displacement.y - arc_height)/ float(gravity))
		print("time %s" % (time_down + time_up))
		
		velocity.y = -sqrt(2*gravity*arc_height)
		velocity.x = displacement.x / float(time_up + time_down)
		
		
	return velocity
	
func launch(target_position):
	var arc_height = target_position.y - global_position.y - 64
	
	velocity = projectile_arc_cacluation(global_position, target_position, arc_height, GRAVITY)
	
	
