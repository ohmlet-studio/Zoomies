extends Node2D

@onready var pause_menu = %PauseMenu


func _on_pause_pressed() -> void:
	pause_menu.show()
	print("paused pressed")
	get_tree().paused = true
