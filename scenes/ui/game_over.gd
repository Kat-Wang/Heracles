extends Control

var checkpoint

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_retry_pressed():
	get_tree().reload_current_scene()
	#$Game/CurrentLevel.add_child(checkpoint)
	#$Game/CurrentLevel.add_child(checkpoint)
	


func _on_exit_pressed():
	get_tree().quit()

