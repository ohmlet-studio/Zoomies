extends Node2D

const DIFFICULTY = 0.5 # between 0 and 1, defined how far the camera start
const MAX_SCENE = 100
const SCALE = 0.28
const PIX_SPEED = 30

# Take scene size * scale
const scene_size_x = 1920 * SCALE
const scene_size_y = 1080 * SCALE

const start_x = -960 + 30
const start_y = -540 + 170
var pos_shift_x = start_x
var pos_shift_y = start_y

# Variable to know if buttons keep pressed
var buttonDownPressed = false
var buttonUpPressed = false

@export var scene_array = Array()
@onready var zoomiesui = $ZoomiesUI

@export var cat_number_by_wave:int = 3

var idx = 0

func _ready() -> void:
	WebcamManager.reset_cats()
	_spawn_cats()

func _spawn_cats() -> void:
	for i in range(cat_number_by_wave-1):
		_instantiate_cat_display()
		await get_tree().create_timer(0.25).timeout
	_instantiate_cat_display()

func _instantiate_cat_display():	
	# ------ Scene instantiation ----------
	var cat_scene = load("res://scenes/cats/random.tscn")
	var cat_scene_node = cat_scene.instantiate()
	
	# this fails because the instance is not ready, help
	# Add scene to parent node
	add_child(cat_scene_node)
	
	cat_scene_node.unalign_camera_random(DIFFICULTY, DIFFICULTY)
	cat_scene_node.connect_cat()
	#WebcamManager.add_new_display(cat_scene_node)
	
	scene_array.append({
		"scene": cat_scene_node,
		"loaded": true
	})
	scene_array[idx]["scene"].scale = Vector2(SCALE, SCALE)
	scene_array[idx]["scene"].position.x = pos_shift_x
	scene_array[idx]["scene"].position.y = pos_shift_y
	# -------------------------------------
	
	# Increment x position for the next scene
	pos_shift_x += scene_size_x + 20
	# Check if next pos shift x allows the scene to be displayed entirely
	if (pos_shift_x + scene_size_x) > (1920/2):
		pos_shift_x = start_x
		pos_shift_y += scene_size_y + 50
	
	idx += 1

func _on_down_button_button_down() -> void:
	buttonDownPressed = true
	
func _on_down_button_button_up() -> void:
	buttonDownPressed = false

func _on_up_button_button_down() -> void:
	buttonUpPressed = true

func _on_up_button_button_up() -> void:
	buttonUpPressed = false

func _process(delta: float) -> void:
	# Check if button is pressed + doesn't allow to go beyond last element
	if (buttonDownPressed && scene_array.back()["scene"].position.y > 0 ):
		for item in scene_array:
			if item["loaded"]:
				item["scene"].position.y -= PIX_SPEED
		pos_shift_y -= PIX_SPEED

	# Same for up button
	if (buttonUpPressed && scene_array.front()["scene"].position.y < start_y ):
		for item in scene_array:
			if item["loaded"]:
				item["scene"].position.y += PIX_SPEED
		pos_shift_y += PIX_SPEED

	# Handle loading/unloading of scenes based on visibility
	#_check_visibility()

func _check_visibility() -> void:
	for item in scene_array:
		var scene = item["scene"]
		var loaded = item["loaded"]

		# Calculate the bottom and top boundaries of the visible area
		var scene_bottom = scene.position.y + scene_size_y + 960
		var scene_top = scene.position.y + 960
		
		# If the scene is completely out of view, unload it
		if scene_bottom < 0 or scene_top > 1500:
			if loaded:
				scene.visible = false
				remove_child(scene)
				item["loaded"] = false
		else:
			# If the scene is within the visible area, reload it if necessary
			if not loaded:
				add_child(scene)
				scene.visible = true
				item["loaded"] = true
