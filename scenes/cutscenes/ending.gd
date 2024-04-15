extends CanvasLayer

func _ready():
	$Chicken.play()
	$AudioStreamPlayer2D.play()

func quit():
	get_tree().quit()

func menu():
	get_tree().change_scene_to_file("res://scenes/game.tscn")
