extends Node3D

var _pan_speed: float = 1
var _zoom_speed: float = 1
var camera;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	camera = get_node("Camera3D")


func _process(delta: float) -> void:
	if Input.is_action_pressed("ui_shift"):
		if Input.is_action_pressed("ui_up"):
			zoom(-_zoom_speed)
		elif Input.is_action_pressed("ui_down"):
			zoom(_zoom_speed)
	else:
		if Input.is_action_pressed("ui_up"):
			rotate_webcam_x(_pan_speed)
		elif Input.is_action_pressed("ui_down"):
			rotate_webcam_x(-_pan_speed)
		
		if Input.is_action_pressed("ui_left"):
			rotate_webcam_y(_pan_speed)
		elif Input.is_action_pressed("ui_right"):
			rotate_webcam_y(-_pan_speed)

#TODO + sound ?

func zoom(speed) -> void:
	camera.fov += speed
	
	if speed < 0:
		if not get_node("zoomInPlayer").is_playing():
			get_node("zoomInPlayer").playing = true
	else:
		if not get_node("zoomOutPlayer").is_playing():
			get_node("zoomOutPlayer").playing = true


func rotate_webcam_x(speed) -> void:
	rotation_degrees.x += speed * camera.fov * 0.01
	
	if not get_node("scrollPlayer").is_playing():
		get_node("scrollPlayer").playing = true

func rotate_webcam_y(speed) -> void:
	rotation_degrees.y += speed * camera.fov * 0.01
	
	if not get_node("scrollPlayer").is_playing():
		get_node("scrollPlayer").playing = true
