extends Level

signal level_complete(next_level:PackedScene)

@onready var bgm := $AudioStreamPlayer2D
@onready var hell_portal := $HellPortal
