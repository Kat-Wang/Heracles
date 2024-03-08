extends Node2D

@onready var player := $Player
@onready var health_bar := $HUD/HealthBar

# Called when the node enters the scene tree for the first time.
func _ready():
	health_bar.setMaxPoms(player.max_health)
	player.healthChanged.connect(health_bar.updatePoms)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
