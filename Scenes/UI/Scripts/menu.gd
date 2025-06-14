extends Control

func _ready() -> void:
	visible = false

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Menu"):
		if visible:
			visible = false
			get_tree().paused = false
		else:
			visible = true
			get_tree().paused = true


func _on_return_to_game_pressed() -> void:
		visible = false
		get_tree().paused = false

func _on_restart_level_pressed() -> void:
	var save_path = Global.SAVE_PATH
	var file = FileAccess.open(save_path, FileAccess.READ)
	
	if file:
		var data = file.get_as_text()
		var save_data = JSON.parse_string(data)
		
		if save_data != null and save_data.has("last_unlocked_level"):
			var level_number = save_data["last_unlocked_level"]
			var level_path = "res://Scenes/Levels/level_%d.tscn" % level_number
			visible = false
			get_tree().paused = false
			get_tree().change_scene_to_file(level_path)
		else:
			print("Save file is missing 'last_unlocked_level'.")
	else:
		print("Could not open save file.")


func _on_return_to_level_picker_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/UI/levels.tscn")


func _on_back_to_main_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/UI/main_menu.tscn")


func _on_settings_pressed() -> void:
	$ColorRect.visible = false
	$VBoxContainer.visible = false
	$Settings.visible = true
