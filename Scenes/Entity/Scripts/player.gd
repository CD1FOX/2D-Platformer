extends CharacterBody2D

var speed = 300
var gravity_force = ProjectSettings.get_setting("physics/2d/default_gravity")

#Jumping Logic
var jump_power = -400
var max_jump = 2
var jump_left = 2
var was_on_floor = false

func player_movement():
	var direction = 0
	
	if Input.is_action_pressed("Left"):
		direction = -1
	if Input.is_action_pressed("Right"):
		direction = 1
		
	velocity.x = direction * speed

func gravity_logic(delta):
	if not is_on_floor():
		velocity.y += gravity_force * delta
		
func jump_logic():
	if Input.is_action_just_pressed("Jump") and jump_left > 0:
		velocity.y = jump_power
		jump_left -= 1

func _physics_process(delta: float) -> void:
	player_movement()
	gravity_logic(delta)
	jump_logic()
	
	if is_on_floor() and not was_on_floor:
		jump_left = max_jump
	
	was_on_floor = is_on_floor()
	
	print(jump_left)
	move_and_slide()
