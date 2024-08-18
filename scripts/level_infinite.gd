extends Node2D

const MAX_SCENE = 100
const SCALE = 0.3

# Take scene size * scale
const scene_size_x = 1920 * SCALE
const scene_size_y = 1080 * SCALE

const start_x = -960 + 60
const start_y = -540 + 150
var pos_shift_x = start_x
var pos_shift_y = start_y

@export var scene_array = Array()
var idx = 0

# Add scene when pressing 'A' (or 'Q' in QWERTY mode), only used in debug mode
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("create_scene"):
		_instantiate_cat_display()


func _instantiate_cat_display():
	print("Instantiation of cat_display n = ", idx)
	
	# ------ Scene instantiation ----------
	var cat_scene = load("res://scenes/cat_display.tscn")
	scene_array.append(cat_scene.instantiate())
	scene_array[idx].scale = Vector2(SCALE, SCALE)
	scene_array[idx].position.x = pos_shift_x
	scene_array[idx].position.y = pos_shift_y
	# -------------------------------------
	
	# Increment x position for the next scene
	pos_shift_x += scene_size_x + 20
	# Check if next pos shift x allows the scene to be displayed entirely
	if (pos_shift_x + scene_size_x) > (1920/2) :
		pos_shift_x = start_x
		pos_shift_y += scene_size_y + 50
	
	# Add scene to parent node
	add_child(scene_array[idx])
	idx += 1
