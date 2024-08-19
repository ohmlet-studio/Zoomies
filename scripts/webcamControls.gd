extends SubViewport

var is_active = false
var _pan_speed: float = 1
var _zoom_speed: float = 1

@onready var camera = $WebcamPivot/Camera3D;
@onready var camera_pivot = $WebcamPivot

# Keep camera default FOV and position
var cam_default_pos_x
var cam_default_pos_y
var cam_default_fov

# Margin for ears detection
@export var EARS_MARGIN_POS = 2
@export var EARS_MARGIN_FOV = 5

var is_aligned = false

func _ready() -> void:
	# Keep default
	cam_default_pos_x = camera_pivot.rotation_degrees.x
	cam_default_pos_y = camera_pivot.rotation_degrees.y
	cam_default_fov = camera.fov	
	# Randomize FOV and position

func _process(delta: float) -> void:
	if !is_active:
		return
	
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
			
	# Check if ears are aligned
	if (
		# X axis
		camera_pivot.rotation_degrees.x < (cam_default_pos_x + EARS_MARGIN_POS) &&
		camera_pivot.rotation_degrees.x > (cam_default_pos_x - EARS_MARGIN_POS) &&
		# Y axis
		camera_pivot.rotation_degrees.y < (cam_default_pos_y + EARS_MARGIN_POS) &&
		camera_pivot.rotation_degrees.y > (cam_default_pos_y - EARS_MARGIN_POS) &&
		# FOV
		camera.fov < (cam_default_fov + EARS_MARGIN_FOV) &&
		camera.fov > (cam_default_fov - EARS_MARGIN_FOV)
	) :
		is_aligned = true
	else :
		is_aligned = false

func zoom(speed) -> void:
	camera.fov += speed
	
	if speed < 0:
		if not $zoomInPlayer.is_playing():
			$zoomInPlayer.playing = true
	else:
		if not $zoomOutPlayer.is_playing():
			$zoomOutPlayer.playing = true


func rotate_webcam_x(speed) -> void:
	camera_pivot.rotation_degrees.x += speed * camera.fov * 0.01
	
	if not $scrollPlayer.is_playing():
		$scrollPlayer.playing = true

func rotate_webcam_y(speed) -> void:
	camera_pivot.rotation_degrees.y += speed * camera.fov * 0.01
	
	if not $scrollPlayer.is_playing():
		$scrollPlayer.playing = true
