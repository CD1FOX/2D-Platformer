extends Node

var score = 0
var running: bool = false
var health = 100
var current_health = 3
var player_dead = false
var last_unlocked_level: int = 1  # Default to level 1
const SAVE_PATH := "user://save_data.save"
var camera_zoom = Vector2(2.5, 2.5)

func _ready():
	load_progress()

func save_progress():
	var save_data = {
		"last_unlocked_level": last_unlocked_level
	}
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	file.store_string(JSON.stringify(save_data))
	file.close()

func load_progress():
	if FileAccess.file_exists(SAVE_PATH):
		var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
		var content = file.get_as_text()
		var save_data = JSON.parse_string(content)
		if typeof(save_data) == TYPE_DICTIONARY:
			last_unlocked_level = save_data.get("last_unlocked_level", 1)
		file.close()
