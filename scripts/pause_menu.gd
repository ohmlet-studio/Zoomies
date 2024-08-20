extends Control



func _on_return_button_pressed() -> void:
	hide()
	get_tree().paused = false
