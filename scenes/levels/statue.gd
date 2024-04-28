extends Area2D

signal save_checkpoint(id)

var in_statue := false

@onready var timer := $Timer
@onready var label := $Label

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if in_statue and Input.is_action_just_pressed("interact"):
		save_checkpoint.emit(get_parent().id)
		timer.start()
		label.visible = true
		

func _on_body_entered(body):
	$Interaction.visible = true
	$Interaction.play()
	in_statue = true


func _on_body_exited(body):
	$Interaction.visible = false
	$Interaction.stop()
	in_statue = false


func _on_timer_timeout():
	label.visible = false
