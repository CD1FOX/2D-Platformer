extends Node

var score = 0
var running: bool = false
var health = 100


var max_health = 3
var current_health = max_health

func reset_health():
	current_health = max_health
