extends Area2D

var already_stepped = false


func _on_body_entered(body: Node2D) -> void:
	if body.name == 'Player' and not already_stepped:
		$AnimatedSprite2D.play("Start")
		Global.starting = true


func _on_body_exited(body: Node2D) -> void:
	if body.name == 'Player':
		already_stepped = true
		
