extends Control

@onready var buttons_v_box = %ButtonsVBox
@onready var start_container = %StartContainer
@onready var option_container = %OptionContainer

func _ready() -> void:
	focus_button()
	
func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/intro/part_two.tscn")
	
func _on_quit_button_pressed() -> void:
	get_tree().quit()

	
func focus_button() -> void:
	if buttons_v_box:
		var button: Button = buttons_v_box.get_child(0)
		if button is Button:
			button.grab_focus()


func _on_visibility_changed():
	if visible:
		focus_button()


func _on_options_button_pressed() -> void:
	start_container.visible = false
	option_container.visible = true

# ------------------ Option menu ----------------------
func _on_return_button_pressed() -> void:
	start_container.visible = true
	option_container.visible = false

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
