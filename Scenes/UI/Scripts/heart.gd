extends Node2D

@onready var hearts = [
	$Heart1/PixelHeartFull,
	$Heart2/PixelHeartFull,
	$Heart3/PixelHeartFull
]

func _process(_delta: float) -> void:
	for i in range(hearts.size()):
		hearts[i].visible = i < Global.current_health
