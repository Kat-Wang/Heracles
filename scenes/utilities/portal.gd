extends Area2D

const FILE_BEGIN = "res://scenes/levels/level_"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$AnimatedSprite2D.play("idle")

func _on_body_entered(body):
	var current_scene_file = get_tree().current_scene.scene_file_path
	var next_level_number = current_scene_file.to_int() + 1
	var next_level_path = FILE_BEGIN + str(next_level_number) + ".tscn"
	print(next_level_number)
	
	get_tree().change_scene_to_file(next_level_path)

	
