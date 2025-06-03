extends CharacterBody2D

var speed = 300
var gravity_force = ProjectSettings.get_setting("physics/2d/default_gravity")
var jump_power = -400

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
	if Input.is_action_pressed("Jump") and is_on_floor():
		velocity.y = jump_power

func _physics_process(delta: float) -> void:
	player_movement()
	gravity_logic(delta)
	jump_logic()
	move_and_slide()
