extends Control



func _on_return_button_pressed() -> void:
	hide()
	get_tree().paused = false



func _on_music_ctrl_slider_value_changed(value: float) -> void:
	var val_temp
	if value <= -50 :
		val_temp = -80
	else:
		val_temp = value
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), val_temp)
	



func _on_sfx_ctrl_slider_value_changed(value: float) -> void:
	var val_temp
	if value <= -50 :
		val_temp = -80
	else:
		val_temp = value
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), val_temp)
