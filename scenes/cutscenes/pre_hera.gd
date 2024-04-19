extends Cutscene

class_name PreHera

signal level_complete(next_level:PackedScene)

@onready var anim_player := $AnimationPlayer
@onready var bgm := $AudioStreamPlayer2D
@onready var cutscene := $Cutscene
@onready var happy := $Happy
@onready var unhappy_broke := $UnhappyBroke
@onready var unhappy_rich := $UnhappyRich
@onready var ending := $Ending

var coins : int

func _ready():
	anim_player.play("pre_hera")
	$Cutscene/Cat.play()
	$Cutscene/BGM.play()
	ending.bgm.stop()
	happy.visible = false
	unhappy_broke.visible = false
	unhappy_rich.visible = false
	ending.visible = false
	
func set_coins(coin_count):
	coins = coin_count
	
func yes():
	cutscene.visible = false

	if coins < 25:
		play_unhappy_broke()
	else:
		play_happy()

func no():
		play_unhappy_rich()

func play_happy():
		happy.visible = true
		anim_player.play("happy")
		$Cutscene/BGM.stop()
		$Happy/BGM.play()
		$Happy/Cat.play()

func play_unhappy_broke():
	cutscene.visible = false
	unhappy_broke.visible = true
	anim_player.play("unhappy_broke")
	$Cutscene/BGM.stop()
	$UnhappyBroke/BGM.play()
	$UnhappyBroke/Cat.play()
	
func play_unhappy_rich():
	cutscene.visible = false
	unhappy_rich.visible = true
	anim_player.play("unhappy_rich")
	$Cutscene/BGM.stop()
	$UnhappyRich/BGM.play()
	$UnhappyRich/Cat.play()

func transition():
	level_complete.emit(next_level)

func _on_skip_pressed():
	transition()

func play_ending():
	#make ending screen scene
	#put that in and fade into it
	# for post hera, transition to ending screen through portal
	$Happy/BGM.stop
	happy.visible = false
	ending.visible = true
