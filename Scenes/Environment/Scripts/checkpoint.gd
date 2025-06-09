extends Area2D

@onready var animated_sprite = $AnimatedSprite2D
var already_stepped = false

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player" and not already_stepped:
		already_stepped = true
		body.initial_position = position  # Update respawn point
		animated_sprite.play("FlagOut")

func _on_animated_sprite_2d_animation_finished() -> void:
	if animated_sprite.animation == "FlagOut":
		animated_sprite.play("Idle")
