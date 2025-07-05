extends Control

@onready var level1_to_12 = $"Level1-12"
@onready var level13_to_24 = $"Level13-24"  # ✅ Fixed typo in name
@onready var level25_to_36 = $"Level25-36"

var current_scene_counter = 1
var selected_level_button: TextureButton = null

func _ready():
	update_visible_levels()
	update_level_visibility()

func handle_level_button_pressed(button: TextureButton) -> void:
	if selected_level_button:
		selected_level_button.modulate = Color.WHITE  # Reset previous button

	selected_level_button = button
	selected_level_button.modulate = Color.GREEN

func _on_next_pressed() -> void:
	if current_scene_counter < 3:
		current_scene_counter += 1
		update_visible_levels()

func _on_previous_pressed() -> void:
	if current_scene_counter > 1:
		current_scene_counter -= 1
		update_visible_levels()

func update_visible_levels():
	level1_to_12.visible = current_scene_counter == 1
	level13_to_24.visible = current_scene_counter == 2
	level25_to_36.visible = current_scene_counter == 3

func update_level_visibility():
	for i in range(1, 37):  # Level 1 to 36
		var level_button_name = "Level%d" % i
		var level_button = find_child(level_button_name, true, false)

		if level_button:
			if i <= Global.last_unlocked_level:
				level_button.disabled = false
				level_button.modulate = Color(1, 1, 1, 1)  # Full brightness ✅
			else:
				level_button.disabled = true
				level_button.modulate = Color(1, 1, 1, 0.5)  # Dimmed ✅


func _on_play_pressed() -> void:
	Global.last_unlocked_level += 1


func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/UI/main_menu.tscn")


func _on_level_1_pressed() -> void:
	var pressed_button = $"Level1-12/Level1" as TextureButton
	handle_level_button_pressed(pressed_button)


func _on_level_2_pressed() -> void:
	var pressed_button = $"Level1-12/Level2" as TextureButton
	handle_level_button_pressed(pressed_button)


func _on_level_3_pressed() -> void:
	var pressed_button = $"Level1-12/Level3" as TextureButton
	handle_level_button_pressed(pressed_button)
