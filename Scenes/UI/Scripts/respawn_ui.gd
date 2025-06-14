extends Control

var player

func _ready() -> void:
	player = $".."

func _process(_delta: float) -> void:
	visible = Global.player_dead


func _on_respawn_pressed() -> void:
	Global.current_health = 3  # ✅ Reset lives
	player.respawn()
	Global.player_dead = false

func _on_main_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/UI/main_menu.tscn")
