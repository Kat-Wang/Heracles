extends HBoxContainer

@onready var pomShard = preload("res://scenes/ui/pom_shard.tscn")

func _ready():
	pass # Replace with function body.

func _process(delta):
	pass

func setMaxPoms(max_health: int):
	for i in max_health:
		var pom = pomShard.instantiate()
		add_child(pom)

func updatePoms(current_health: int, healing: bool):
	print("updating poms")
	var poms = get_children()
	
	if healing:
		pass
	else:
		for i in current_health:
			poms[i].update(true)
		
		for i in range(current_health, poms.size()):
			poms[i].update(false)
