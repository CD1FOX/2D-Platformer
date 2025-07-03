extends Area2D

@onready var anim = $AnimatedSprite2D

var already_stepped = false
var fire_touched = false

func _process(delta: float) -> void:
	while fire_touched:
		Global.health -= 10 * delta
		await get_tree().create_timer(0.2).timeout

func _on_body_entered(body: Node2D) -> void:
	if not already_stepped and body.is_in_group("Player"):
		already_stepped = true
		anim.play("Hit")
		await get_tree().create_timer(0.5).timeout
		anim.play("On")
		$Area2D/CollisionShape2D.disabled = false
		await get_tree().create_timer(3).timeout
		$Area2D/CollisionShape2D.disabled = true
		anim.play("Off")
		await get_tree().create_timer(1).timeout
		already_stepped = false


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		fire_touched = true


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		fire_touched = false
