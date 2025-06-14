extends CharacterBody2D

var speed = 220
var gravity_force = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var animated_sprite = $AnimatedSprite2D
var initial_position = Vector2(0, 0)
var is_dead = false

#Jumping Logic
var jump_power = -320
var max_jump = 2
var jump_left = 2
var was_on_floor = false

func die():
	if is_dead:
		return

	$CollisionShape2D.disabled = true
	is_dead = true
	animated_sprite.play("Disappearing")

	Global.current_health -= 1  # ✅ Deduct 1 heart

	await animated_sprite.animation_finished  # ✅ Wait for death animation

	if Global.current_health <= 0:
		Global.player_dead = true  # ✅ Show UI and stop everything
		set_physics_process(false)
	else:
		respawn()  # ✅ Respawn only if hearts are left

func respawn():
	position = initial_position
	is_dead = false
	Global.health = 100
	$CollisionShape2D.disabled = false
	set_physics_process(true)

func player_movement():
	var direction = 0

	if Input.is_action_pressed("Left"):
		direction = -1
		animated_sprite.flip_h = true
	elif Input.is_action_pressed("Right"):
		direction = 1
		animated_sprite.flip_h = false

	velocity.x = direction * speed

	# Animation logic
	if direction != 0:
		animated_sprite.play("Run")
	else:
		animated_sprite.play("Idle")


func gravity_logic(delta):
	if not is_on_floor():
		if velocity.y < 0:
			animated_sprite.play("Jump")
		elif velocity.y > 0:
			animated_sprite.play("Fall")
		velocity.y += gravity_force * delta
		
		
func jump_logic():
	if Input.is_action_just_pressed("Jump") and jump_left > 0:
		
		velocity.y = jump_power
		jump_left -= 1

func _physics_process(delta: float) -> void:
	if Global.health <= 0.0:
		die()
	
	if is_dead:
		return
	
	$Camera2D.zoom = Global.camera_zoom
	player_movement()
	gravity_logic(delta)
	jump_logic()
	
	if is_on_floor() and not was_on_floor:
		jump_left = max_jump
	
	
	was_on_floor = is_on_floor()
	
	move_and_slide()
