extends Node2D

@onready var nine_patch = $Parent2D/NinePatchRect
@onready var sprite = $Parent2D/CatDisplaySprite
@onready var sub_viewport = $SubViewport
@onready var parent2D = $Parent2D

@export var default_boder_color = Color("d7d7d7")
@export var border_color_focus = Color(0, 0, 0.545098, 1)
@export var border_color_hover = Color("white")

@export var randomize_room: bool
@export var randomize_cat: bool
@export var cat_body: Texture2D
@export var cat_eyes: Texture2D
@export var wallpaper: Texture2D
@export var floor: Texture2D
@export var room_objects: Array[Texture2D]

var border_color = default_boder_color

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# ----------- Pick random texture -------------
	if randomize_cat:
		cat_body = _get_random_texture("res://assets/textures/cat_parts/body/")
		cat_eyes = _get_random_texture("res://assets/textures/cat_parts/eyes/normal/")
	
	if randomize_room:
		floor = _get_random_texture("res://assets/textures/rooms/floors/")
		wallpaper = _get_random_texture("res://assets/textures/rooms/wallpapers/")
	# ---------------------------------------------
	
	$SubViewport/cat/baseplate.texture = cat_body
	$SubViewport/cat/eyes.texture = cat_eyes
	
	var wallpaper_material = $SubViewport/room/wallpaper.get_surface_override_material(0)
	wallpaper_material.albedo_texture = wallpaper
	
	var floor_material = $SubViewport/room/floor.get_surface_override_material(0)
	floor_material.albedo_texture = floor
	
	#sub_viewport.room_objects = room_objects
	
	# set the sprite texture to the viewport
	sprite.texture = sub_viewport.get_texture()
	sub_viewport.render_target_update_mode = SubViewport.UPDATE_ONCE
	
	# set the sprite invisible
	parent2D.visible = false
	
	enable_input()

func disable_input():
	sub_viewport.is_input_enabled = false
	
func enable_input():
	sub_viewport.is_input_enabled = true

func unalign_camera_random(scale_fov, scale_rotation):
	var rng = RandomNumberGenerator.new()
	sub_viewport.camera.fov =  rng.randf_range(scale_fov*sub_viewport.LIMIT_FOV_MIN, scale_fov*sub_viewport.LIMIT_FOV_MAX)
	
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

func connect_cat():
	$connect_sound.play()
	parent2D.visible = true
	
func disconnect_cat():
	$disconnect_sound.play()
	parent2D.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# set border color
	nine_patch.modulate = border_color
	
	# change color if aligned
	if sub_viewport.is_aligned :
		border_color = Color("Green")
	else:
		border_color = Color(0, 0, 0.545098, 1)
	

func mouse_enter():
	border_color = border_color_hover

func mouse_exit():
	border_color = border_color

func mouse_focus():
	border_color = border_color_focus

# Function to handle the sprite click
func _on_sprite_input():
	sub_viewport.render_target_update_mode = SubViewport.UPDATE_ALWAYS
	sub_viewport.is_active = true
	border_color = Color(0, 0, 0.545098, 1)
	await get_tree().create_timer(60).timeout
	sub_viewport.is_active = false
	sub_viewport.render_target_update_mode = SubViewport.UPDATE_ONCE
	border_color = Color("#d7d7d7")
