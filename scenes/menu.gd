extends Control

@onready var bgm := $AudioStreamPlayer

func _ready():
	bgm.play()
	
func _on_play_pressed():
	get_tree().change_scene_to_file("res://scenes/lore.tscn")


func _on_quit_pressed():
	get_tree().quit()
