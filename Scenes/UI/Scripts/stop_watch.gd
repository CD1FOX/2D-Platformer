extends Control

var time_passed := float(0)

func _process(delta: float) -> void:
	if Global.running:
		time_passed += delta
		update_time()

func update_time():
	var minutes = float(time_passed) / 60
	var seconds = int(time_passed) % 60
	
	$Label.text = "%02d:%02d" % [minutes, seconds]
