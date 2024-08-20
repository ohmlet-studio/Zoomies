extends Node

@onready var speech_scene = preload("res://scenes/ui/speech_bubble.tscn")

var dialog_lines: Array[String] = []
var current_line_index = 0

var text_box
var text_box_position: Vector2

var is_dialog_active = false
var can_advance_line = false

var cat_display

signal dialog_finish()

func start_dialog(lines: Array[String], cat_display: Node2D):
	if is_dialog_active:
		return
	
	self.cat_display = cat_display
	self.dialog_lines = lines
		
	var display_size = cat_display.get_node("Parent2D/CatDisplaySprite").get_rect().size
	text_box_position = cat_display.global_position + Vector2(display_size.x/3, display_size.y/12)
	_show_text_box()
	
	is_dialog_active = true
	
func _show_text_box():
	text_box = speech_scene.instantiate()
	text_box.finished_displaying.connect(_on_text_box_finished_displaying)
	get_tree().root.add_child(text_box)
	text_box.global_position = text_box_position
	text_box.display_text(dialog_lines[current_line_index], text_box_position, cat_display)
	can_advance_line = false
	
func _on_text_box_finished_displaying():
	can_advance_line = true
	
func _unhandled_input(event):
	if (
		event.is_action_pressed("ui_accept") &&	
		is_dialog_active &&
		can_advance_line
	):
		text_box.queue_free()
		
		current_line_index += 1
		if current_line_index >= dialog_lines.size():
			is_dialog_active = false
			current_line_index = 0
			dialog_finish.emit()
			return
			
		_show_text_box()
		
	elif (
		event.is_action_pressed("ui_accept") &&
		is_dialog_active &&
		(can_advance_line == false)
	) :
		text_box.display_all = true
