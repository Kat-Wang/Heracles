extends Node

@onready var anim_player := $AnimationPlayer
@onready var bgm := $AudioStreamPlayer2D


# Called when the node enters the scene tree for the first time.
func _ready():
	anim_player.play("intro")
	bgm.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func intro_finished():
	anim_player.play("main")

func main_finished():
	anim_player.play("ending")
	
func ending_finished():
	get_tree().change_scene_to_file("res://scenes/game.tscn")
