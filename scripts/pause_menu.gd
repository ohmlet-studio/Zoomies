extends Control

func _on_return_button_pressed() -> void:
	hide()
	get_tree().paused = false

func _on_main_menu_button_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/ui/main_menu.tscn")
