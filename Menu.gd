extends Control

@onready var bgm := $AudioStreamPlayer

func _ready():
	bgm.play()
	
func _on_play_pressed():
	get_tree().change_scene_to_file("res://.godot/exported/133200997/export-c2a7af834e91ff64325daddf58e45dc0-game.scn")


func _on_quit_pressed():
	get_tree().quit()
