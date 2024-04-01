extends Area2D

var in_fountain := false
var player:Player

@onready var healing_sfx := $AudioStreamPlayer2D

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if in_fountain and Input.is_action_just_pressed("interact"):
		#player.current_health = player.max_health
		player.heal(true)
		healing_sfx.play()


func _on_body_entered(body):
	if body is Player:
		$Interaction.visible = true
		$Interaction.play()
		in_fountain = true
		player = body
	


func _on_body_exited(body):
	if body is Player:
		$Interaction.visible = false
		$Interaction.stop()
		in_fountain = false
		player = null
	
