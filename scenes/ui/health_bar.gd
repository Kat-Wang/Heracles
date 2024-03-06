extends HBoxContainer

@onready var pomShard = preload("res://scenes/ui/pom_shard.tscn")

func _ready():
	pass # Replace with function body.

func _process(delta):
	pass

func setMaxHearts(max: int):
	for i in max:
		var pom = pomShard.instantiate()
		add_child(pom)
