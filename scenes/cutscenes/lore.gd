extends Node

@onready var anim_player := $AnimationPlayer
@onready var bgm := $AudioStreamPlayer2D
@onready var intro := $Intro
@onready var main := $Main
@onready var ending := $Ending


# Called when the node enters the scene tree for the first time.
func _ready():
	anim_player.play("intro")
	bgm.play()
	main.visible = false
	ending.visible = false
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func intro_finished():
	anim_player.play("main")
	intro.visible = false
	main.visible = true

func main_finished():
	anim_player.play("ending")
	main.visible = false
	ending.visible = true
	
func ending_finished():
	get_tree().change_scene_to_file("res://scenes/game.tscn")

func _on_skip_pressed():
	get_tree().change_scene_to_file("res://scenes/game.tscn")
