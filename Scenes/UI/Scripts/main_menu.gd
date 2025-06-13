extends Control



func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/UI/levels.tscn")


func _on_exit_pressed() -> void:
	$ExitConfirmationDialog.popup_centered()


func _on_exit_confirmation_dialog_confirmed() -> void:
	get_tree().quit()
