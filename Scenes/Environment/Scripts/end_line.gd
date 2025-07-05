extends Area2D

var already_stepped = false


func _on_body_entered(body: Node2D) -> void:
	if body.name == 'Player' and not already_stepped:
		$AnimatedSprite2D.play("End")
		Global.last_unlocked_level += 1
		Global.save_progress()
		Global.running = false

func _on_body_exited(body: Node2D) -> void:
	if body.name == 'Player':
		already_stepped = true
