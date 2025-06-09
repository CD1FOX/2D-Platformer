extends Area2D

@onready var animated_sprite = $AnimatedSprite2D
var player_on_trap = false

func _ready():
	animated_sprite.play("Off")  # Start with idle animation

func _on_body_entered(body):
	if body.name == "Player" and animated_sprite.animation == "Off":
		# When player first steps on trap
		player_on_trap = true
		activate_trap()

func _on_body_exited(body):
	if body.name == "Player":
		player_on_trap = false

func activate_trap():
	# Step 1: Play the hit animation (triggering the trap)
	animated_sprite.play("Hit")
	await animated_sprite.animation_finished
	
	# Step 2: Switch to fire animation (On state)
	animated_sprite.play("On")
	Global.health -= 10  # Initial damage when triggered
	
	# Keep damaging player while they stay on the burning trap
	var fire_timer = 0.0
	while fire_timer < 5.0 and player_on_trap:
		fire_timer += get_process_delta_time()
		Global.health -= 2 * get_process_delta_time()  # 2 damage per second
		await get_tree().process_frame
	
	# Step 3: Return to idle state
	animated_sprite.play("Off")
