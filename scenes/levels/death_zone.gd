extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_death_zone_body_entered(body):
	print("death zone entered")
	
	#for child in body.get_children():
	if body is Player:
		print("player should die")
		body.current_health = 0
		body.healthChanged.emit(body.current_health, false)
		body.damagable.hit(500, Vector2.RIGHT)
			
