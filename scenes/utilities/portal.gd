extends Area2D

signal portal_entered

func _ready():
	pass # Replace with function body.

func _process(delta):
	$AnimatedSprite2D.play("idle")

func _on_body_entered(body):
	portal_entered.emit()
#
	
