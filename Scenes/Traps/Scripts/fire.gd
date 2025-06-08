extends Area2D

@onready var animated_sprite = $AnimatedSprite2D
var duration = 5
var already_stepped = false

func _process(delta: float) -> void:
	if already_stepped:
		duration -= delta
	
	if duration <= 0:
		if animated_sprite.animation == "On":
			animated_sprite.play("Off")
		duration = 5 
		already_stepped = false
		
	
	print(duration, animated_sprite.animation)


func _on_body_entered(body: Node2D) -> void:
	if body.name == 'Player' and not already_stepped:
		already_stepped = true
		animated_sprite.play("Hit")
		


func _on_animated_sprite_2d_animation_finished() -> void:
	if animated_sprite.animation == "Hit":
		animated_sprite.play("On")
