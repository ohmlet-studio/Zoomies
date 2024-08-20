extends Node2D

@onready var nine_patch = $Parent2D/NinePatchRect
@onready var sprite = $Parent2D/CatDisplaySprite
@onready var sub_viewport = $SubViewport
@onready var parent2D = $Parent2D
@onready var parent3D = $SubViewport/Parent3D
@onready var cat = $SubViewport/Parent3D/cat


# Objects sprites
@onready var first_plan_obj = %firstPlan
@onready var second_plan_obj = %secondPlan
@onready var third_plan_obj = %thirdPlan
@onready var mug_obj = %mug
@onready var mouse_obj = %mouse

# Object position boundary
var object_lim_x_axis = 10

@export var default_boder_color = Color("d7d7d7")
@export var border_color_focus = Color(0, 0, 0.545098, 1)
@export var border_color_hover = Color("white")

@export var randomize_room: bool
@export var randomize_cat: bool
@export var cat_body: Texture2D
@export var cat_eyes: Texture2D
@export var wallpaper: Texture2D
@export var floor_texture: Texture2D
#@export var room_objects: Array[Texture2D]

# object list for web compatibility
var first_plan_objects_list: Array[Texture]
var second_plan_objects_list: Array[Texture]
var third_plan_objects_list: Array[Texture]
var floors_list: Array[Texture]
var wallpapers_list: Array[Texture]
var cat_bodies_list: Array[Texture]
var cat_eyes_list: Array[Texture]
var mug_list: Array[Texture]
var mouse_list: Array[Texture]

# mouth animations
var mouth_talking_poses: Array[Texture2D] = []
var mouth_idle_texture: Texture2D

var border_color = default_boder_color

signal ears_aligned_in()
signal ears_aligned_out()
signal hint_range_in()
signal hint_range_out()

var cinematic_mode = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if randomize_cat or randomize_room:
		var cat_bodies_paths = ["res://assets/textures/cat_parts/body/Body1.png", "res://assets/textures/cat_parts/body/Body2.png", "res://assets/textures/cat_parts/body/Body3.png", "res://assets/textures/cat_parts/body/Body4.png", "res://assets/textures/cat_parts/body/Body5.png", "res://assets/textures/cat_parts/body/Body6.png", "res://assets/textures/cat_parts/body/Body7.png", "res://assets/textures/cat_parts/body/Body8.png", "res://assets/textures/cat_parts/body/Body9.png", "res://assets/textures/cat_parts/body/Body10.png", "res://assets/textures/cat_parts/body/Body11.png", "res://assets/textures/cat_parts/body/Body12.png", "res://assets/textures/cat_parts/body/Body13.png", "res://assets/textures/cat_parts/body/Body14.png", "res://assets/textures/cat_parts/body/Body15.png", "res://assets/textures/cat_parts/body/Body16.png", "res://assets/textures/cat_parts/body/Body17.png", "res://assets/textures/cat_parts/body/Body18.png"]
		for path in cat_bodies_paths:
			cat_bodies_list.append(load(path))
			
		var cat_eyes_paths = ["res://assets/textures/cat_parts/eyes/normal/oval.png", "res://assets/textures/cat_parts/eyes/normal/sexy.png", "res://assets/textures/cat_parts/eyes/normal/wide.png"]
		for path in cat_eyes_paths:
			cat_eyes_list.append(load(path))

		var mug_paths = ["res://assets/textures/rooms/objects/mug/colored/blanc.png", "res://assets/textures/rooms/objects/mug/colored/bleu.png", "res://assets/textures/rooms/objects/mug/colored/greenyarn.png", "res://assets/textures/rooms/objects/mug/colored/orange.png", "res://assets/textures/rooms/objects/mug/colored/orangeyarn.png"]
		for path in mug_paths:
			mug_list.append(load(path))
			
		var mouth_talking_poses_paths = ["res://assets/textures/cat_parts/mouth/big_smile.png", "res://assets/textures/cat_parts/mouth/chock.png", "res://assets/textures/cat_parts/mouth/smile.png"]
		for path in mouth_talking_poses_paths:
			mouth_talking_poses.append(load(path))
		
		var first_plan_objects_paths = ["res://assets/textures/rooms/objects/first_plan/lavalamp.png"]
		for path in first_plan_objects_paths:
			first_plan_objects_list.append(load(path))

		var second_plan_objects_paths = ["res://assets/textures/rooms/objects/second_plan/aloevera.png", "res://assets/textures/rooms/objects/second_plan/monstera.png"]
		for path in second_plan_objects_paths:
			second_plan_objects_list.append(load(path))

		var third_plan_objects_paths = ["res://assets/textures/rooms/objects/third__plan/drawer.png", "res://assets/textures/rooms/objects/third__plan/meuble.png"]
		for path in third_plan_objects_paths:
			third_plan_objects_list.append(load(path))
		
		var wallpapers_paths = ["res://assets/textures/rooms/wallpapers/duck.jpg", "res://assets/textures/rooms/wallpapers/fish.jpg", "res://assets/textures/rooms/wallpapers/paws.jpg", "res://assets/textures/rooms/wallpapers/squares.jpg", "res://assets/textures/rooms/wallpapers/vertical_stripes.jpg"]
		for path in wallpapers_paths:
			wallpapers_list.append(load(path))
		
		var floors_paths = ["res://assets/textures/rooms/floors/boards.jpg", "res://assets/textures/rooms/floors/tiles.jpg"]
		for path in floors_paths:
			floors_list.append(load(path))
		
		var mouse_paths = ["res://assets/textures/rooms/objects/mouse/blue.png", "res://assets/textures/rooms/objects/mouse/purple.png", "res://assets/textures/rooms/objects/mouse/yellow.png"]
		for path in mouse_paths:
			mouse_list.append(load(path))
			
		mouth_idle_texture = load("res://assets/textures/cat_parts/mouth/neutral.png")

	# ----------- Pick random texture -------------
	if randomize_cat:
		#cat_body = _get_random_texture("res://assets/textures/cat_parts/body/")
		cat_body = cat_bodies_list[randi() % cat_bodies_list.size()]
		#cat_eyes = _get_random_texture("res://assets/textures/cat_parts/eyes/normal/")
		cat_eyes = cat_eyes_list[randi() % cat_eyes_list.size()]
	
	if randomize_room:
		# Get wall and floor texture
		#floor_texture = _get_random_texture("res://assets/textures/rooms/floors/")
		floor_texture = floors_list[randi() % floors_list.size()]
		#wallpaper = _get_random_texture("res://assets/textures/rooms/wallpapers/")
		wallpaper = wallpapers_list[randi() % wallpapers_list.size()]
		
		# Get object texture
		#first_plan_obj.set_texture(_get_random_texture("res://assets/textures/rooms/objects/first_plan/"))
		first_plan_obj.set_texture(first_plan_objects_list[randi() % first_plan_objects_list.size()])
		#second_plan_obj.set_texture(_get_random_texture("res://assets/textures/rooms/objects/second_plan/"))
		second_plan_obj.set_texture(second_plan_objects_list[randi() % second_plan_objects_list.size()])
		
		#third_plan_obj.set_texture(_get_random_texture("res://assets/textures/rooms/objects/third__plan/"))
		third_plan_obj.set_texture(third_plan_objects_list[randi() % third_plan_objects_list.size()])
		#mug_obj.set_texture(_get_random_texture("res://assets/textures/rooms/objects/mug/colored/"))
		mug_obj.set_texture(mug_list[randi() % mug_list.size()])
		#mouse_obj.set_texture(_get_random_texture("res://assets/textures/rooms/objects/mouse/"))
		mouse_obj.set_texture(mouse_list[randi() % mouse_list.size()])
		
		# Randomize object X axis
		first_plan_obj.translate(Vector3(randf_range(5, object_lim_x_axis), 0, 0))
		second_plan_obj.translate(Vector3(randf_range(5, object_lim_x_axis), 0, 0))
		third_plan_obj.translate(Vector3(randf_range(5, object_lim_x_axis), 0, 0))
		
	# ---------------------------------------------
	
	$SubViewport/Parent3D/cat/baseplate.texture = cat_body
	$SubViewport/Parent3D/cat/eyes.texture = cat_eyes
	
	var original_wall_material = $SubViewport/Parent3D/room/wall_behind.get_surface_override_material(0)
	var wallpaper_material = original_wall_material.duplicate()
	# duplicate material and reaplly it so it only changes this one
	$SubViewport/Parent3D/room/wall_behind.set_surface_override_material(0, wallpaper_material)
	$SubViewport/Parent3D/room/wall_left.set_surface_override_material(0, wallpaper_material)
	$SubViewport/Parent3D/room/wall_right.set_surface_override_material(0, wallpaper_material)

	wallpaper_material.albedo_texture = wallpaper

	var original_floor_material = $SubViewport/Parent3D/room/floor.get_surface_override_material(0)
	var floor_material = original_floor_material.duplicate()
	# duplicate material and reaplly it so it only changes this one
	$SubViewport/Parent3D/room/floor.set_surface_override_material(0, floor_material)
	floor_material.albedo_texture = floor_texture

	#sub_viewport.room_objects = room_objects
	
	# set the sprite texture to the viewport
	sprite.texture = sub_viewport.get_texture()
	sub_viewport.render_target_update_mode = SubViewport.UPDATE_ONCE
	
	# set the sprite invisible
	parent2D.visible = false
	
	WebcamManager.add_new_display(self)

func set_cinematic_mode(is_enabled):
	cinematic_mode = is_enabled
	
	if is_enabled:
		disable_input()
		$Parent2D/EarHint.hide()
	else:
		$Parent2D/EarHint.hide()
		enable_input()

func disable_input():
	sub_viewport.is_input_enabled = false
	
func enable_input():
	sub_viewport.is_input_enabled = true

func unalign_camera_random(scale_fov, scale_rotation):
	var rng = RandomNumberGenerator.new()
	sub_viewport.camera.fov = rng.randf_range(scale_fov*sub_viewport.LIMIT_FOV_MIN, scale_fov*sub_viewport.LIMIT_FOV_MAX)
	
	var random_rotation = Vector3(
		 rng.randf_range(scale_rotation*sub_viewport.LIMIT_X_MIN, scale_rotation*sub_viewport.LIMIT_X_MAX),
		 rng.randf_range(scale_rotation*sub_viewport.LIMIT_Y_MIN, scale_rotation*sub_viewport.LIMIT_Y_MAX),
		 sub_viewport.camera_pivot.rotation_degrees.z
	)
	
	sub_viewport.render_target_update_mode = SubViewport.UPDATE_ONCE
	
	sub_viewport.camera_pivot.rotation_degrees =  random_rotation
	

func _get_random_texture(path : String) -> Texture2D:
	var dir_name := path
	var dir := DirAccess.open(dir_name)
	var file_names := dir.get_files()
	# Delete import file from array
	for file in file_names:
		if file.contains(".import") :
			file_names.remove_at(file_names.find(file))

	var random_file = file_names[randi() % file_names.size()]
	var res := load(dir_name + random_file)
	return res

func connect_cat(cinematic:bool=false):
	var tween = get_tree().create_tween()
	
	$connect_sound.play()
	parent2D.visible = true
	
	# connect animation
	var target_scale_y = parent2D.scale.y
	parent2D.scale.y = 0
	
	# Create and configure the tween
	tween.tween_property(parent2D, "scale:y", target_scale_y, 0.2).set_trans(Tween.TRANS_SINE)

	set_cinematic_mode(cinematic)
	
func disconnect_cat():
	$disconnect_sound.play()
	var target_scale_y = 0
	
	# Create and configure the tween
	var tween = get_tree().create_tween()
	tween.tween_property(parent2D, "scale:y", target_scale_y, 0.2).set_trans(Tween.TRANS_SINE)
	tween.tween_callback(free)
	
func change_mouth_pose():
	# get a random element from mouth_talking_poses
	var random_texture = mouth_talking_poses[randi() % mouth_talking_poses.size()]
	cat.get_node("mouth").texture = random_texture

func set_mouth_idle():
	cat.get_node("mouth").texture = mouth_idle_texture
	
func blink():
	pass #TODO	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	nine_patch.modulate = border_color

func on_ears_aligned_in():
	if cinematic_mode:
		return
		
	$Parent2D/EarHint.hide()
	$Parent2D/EarHintAligned.show()
	ears_aligned_in.emit()
	WebcamManager.check_are_cats_aligned()
	
func on_ears_aligned_out():
	if cinematic_mode:
		return
		
	$Parent2D/EarHintAligned.hide()
	$Parent2D/EarHint.show()
	ears_aligned_out.emit()

func on_hint_aligned_in():
	if cinematic_mode:
		return
		
	$Parent2D/EarHint.show()
	hint_range_in.emit()
	
func on_hint_aligned_out():
	if cinematic_mode:
		return
		
	$Parent2D/EarHint.hide()
	hint_range_out.emit()

func mouse_enter():
	border_color = border_color_hover

func mouse_exit():
	border_color = default_boder_color

func mouse_focus():
	border_color = border_color_focus

func activate():
	sub_viewport.is_active = true
	border_color = border_color_focus
	sub_viewport.render_target_update_mode = SubViewport.UPDATE_ALWAYS

func deactivate():
	sub_viewport.is_active = false
	border_color = default_boder_color
	update_once()

func move_room(n):
	parent3D.position.z += 100 * n

func update_once():
	sub_viewport.render_target_update_mode = SubViewport.UPDATE_ONCE

# Function to handle the sprite click
func _on_sprite_input():
	WebcamManager.change_focus(self)

func is_aligned():
	return sub_viewport.is_aligned
