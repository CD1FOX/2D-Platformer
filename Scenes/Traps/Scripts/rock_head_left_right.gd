extends CharacterBody2D

@export var max_speed: float = 400.0       # Maximum speed cap
@export var acceleration: float = 200.0    # How fast it accelerates
@export var initial_speed: float = 100.0   # Starting speed

@onready var right_raycast: RayCast2D = $RightDetector
@onready var left_raycast: RayCast2D = $LeftDetector



var current_speed: float = 0.0
var direction: int = 1  # Start moving to the right


func _physics_process(delta: float) -> void:
	update_raycast()
	check_collisions()

	# Accelerate over time (up to max_speed)
	current_speed = min(current_speed + acceleration * delta, max_speed)

	# Move trap
	velocity.x = direction * current_speed
	move_and_slide()

func update_raycast() -> void:
	left_raycast.force_raycast_update()
	right_raycast.force_raycast_update()

func check_collisions() -> void:
	if right_raycast.is_colliding() and right_raycast.get_collider() is TileMapLayer:
		direction = -1
		current_speed = initial_speed

	if left_raycast.is_colliding() and left_raycast.get_collider() is TileMapLayer:
		direction = 1
		current_speed = initial_speed

	# ✅ Only damage the player if still alive
	if Global.health >= 0:
		var player_left = left_raycast.get_collider()
		var player_right = right_raycast.get_collider()
		if player_left is CharacterBody2D and player_left.has_method("die"):
			player_left.die()
		if player_right is CharacterBody2D and player_right.has_method("die"):
			player_right.die()
