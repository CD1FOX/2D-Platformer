extends StaticBody2D

var stepping_in_spike = false

func _process(delta: float) -> void:
	while stepping_in_spike:
		Global.health -= 15 
		await get_tree().create_timer(0.4).timeout


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player") and not Global.player_dead:
		stepping_in_spike = true


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player") and not Global.player_dead:
		stepping_in_spike = false
