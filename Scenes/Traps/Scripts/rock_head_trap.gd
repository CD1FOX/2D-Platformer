extends CharacterBody2D

enum Direction { UP, RIGHT, DOWN, LEFT }
var current_direction = Direction.UP
var speed = 100  
var min_speed = 100  
var max_speed = 750 
var acceleration = 250  
var waiting_for_cooldown = false

@onready var animation = $AnimatedSprite2D
@onready var trap_collision = $TrapCollision

@onready var raycasts := [
	$Up,
	$Right,
	$Down,
	$Left
]

@onready var cooldown_timers := [
	$Cooldown_UP,
	$Cooldown_RIGHT,
	$Cooldown_DOWN,
	$Cooldown_LEFT
]

func _physics_process(_delta: float) -> void:
	if waiting_for_cooldown:
		velocity = Vector2.ZERO
		move_and_slide()
		return

	# ✅ Increase speed slowly until max
	if speed < max_speed:
		speed += acceleration * _delta 

	# Directional movement
	var directions = [
		Vector2(0, -1),
		Vector2(1, 0),
		Vector2(0, 1),
		Vector2(-1, 0)
	]
	velocity = directions[current_direction] * speed

	# Raycast and collision check
	var raycast = raycasts[current_direction]
	if raycast.is_colliding():
		var collider = raycast.get_collider()
		if collider and not collider.is_in_group("Player"):
			animation.modulate.a = 1
			trap_collision.disabled = false
			match current_direction:
				Direction.UP: animation.play("up_anim")
				Direction.RIGHT: animation.play("right_anim")
				Direction.DOWN: animation.play("bottom_anim")
				Direction.LEFT: animation.play("left_anim")
			
			waiting_for_cooldown = true
			raycast.enabled = false
			cooldown_timers[current_direction].start()
		elif collider and collider.is_in_group("Player"): 
			animation.modulate.a = 0.5
			trap_collision.disabled = true
			

	move_and_slide()

func _on_cooldown_timeout() -> void:
	animation.play("Idle")
	waiting_for_cooldown = false
	current_direction = ((current_direction + 1) % 4) as Direction
	speed = min_speed 

	# Re-enable all raycasts when completing the full cycle
	if current_direction == Direction.UP:
		for ray in raycasts:
			ray.enabled = true


func _on_animated_sprite_2d_animation_finished() -> void:
	if waiting_for_cooldown: animation.play("Blink")
