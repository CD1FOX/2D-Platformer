extends Control

func _process(_delta: float) -> void:
	$TextureProgressBar.value = Global.health
