extends Cutscene

@onready var bgm := $AudioStreamPlayer2D

func _ready():
	$Chicken.play()
	bgm.play()

func quit():
	get_tree().quit()

func menu():
	get_tree().change_scene_to_file("res://scenes/menu.tscn")
