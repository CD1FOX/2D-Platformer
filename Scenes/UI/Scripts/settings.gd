extends VBoxContainer


func _on_button_pressed() -> void:
	visible = false
	$"../Menu".visible = true
