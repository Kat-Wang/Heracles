extends Cutscene

@onready var bgm := $AudioStreamPlayer2D
@onready var anim_player := $AnimationPlayer

func _ready():
	$Chicken.play()
	bgm.play()
	$CreditsPage.visible = false

func quit():
	get_tree().quit()

func menu():
	get_tree().change_scene_to_file("res://scenes/menu.tscn")


func credits():
	anim_player.play("credits_fadein")

func back():
	anim_player.play("credits_fadeout")
