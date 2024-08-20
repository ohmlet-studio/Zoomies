extends SubViewport

var is_active = false
var is_input_enabled = true;

@export var _pan_speed: float = 50
@export var _zoom_speed: float = 50

@onready var camera = $Parent3D/WebcamPivot/Camera3D;
@onready var camera_pivot = $Parent3D/WebcamPivot
@onready var ding_player = $ding_player

# Keep camera default FOV and position
var cam_default_pos_x
var cam_default_pos_y
var cam_default_fov

# Margin for ears detection
@export var EARS_MARGIN_POS = 2
@export var EARS_MARGIN_FOV = 5

# Camera limits
@export var LIMIT_FOV_MIN = 1
@export var LIMIT_FOV_MAX = 140
@export var LIMIT_X_MIN = -75
@export var LIMIT_X_MAX = 75
@export var LIMIT_Y_MIN = -40
@export var LIMIT_Y_MAX = 70


var is_aligned = false
var is_in_hint_range = false

signal ears_aligned_in()
signal ears_aligned_out()
signal hint_range_in()
signal hint_range_out()

func _ready() -> void:
	# Keep default
	cam_default_pos_x = camera_pivot.rotation_degrees.x
	cam_default_pos_y = camera_pivot.rotation_degrees.y
	cam_default_fov = camera.fov

func _process(delta: float) -> void:
	if !is_active:
		return
	
	if !is_input_enabled:
		return
	
	if Input.is_action_pressed("ui_left"):
		if camera_pivot.rotation_degrees.y < LIMIT_X_MAX :
			rotate_webcam_y(_pan_speed * delta)
	elif Input.is_action_pressed("ui_right"):
		if camera_pivot.rotation_degrees.y > LIMIT_X_MIN :
			rotate_webcam_y(-_pan_speed * delta)
	
	if Input.is_action_pressed("ui_shift"):
		# Check limit
		if Input.is_action_pressed("ui_up"):
			if camera.fov > LIMIT_FOV_MIN :
				zoom(-_zoom_speed * delta)
		elif Input.is_action_pressed("ui_down"):
			if camera.fov < LIMIT_FOV_MAX :
				zoom(_zoom_speed * delta)
	else:
		if Input.is_action_pressed("ui_up"):
			if camera_pivot.rotation_degrees.x < LIMIT_Y_MAX :
				rotate_webcam_x(_pan_speed * delta)
		elif Input.is_action_pressed("ui_down"):
			if camera_pivot.rotation_degrees.x > LIMIT_Y_MIN :
				rotate_webcam_x(-_pan_speed * delta)
		
		if Input.is_action_pressed("ui_left"):
			if camera_pivot.rotation_degrees.y < LIMIT_X_MAX :
				rotate_webcam_y(_pan_speed * delta)
		elif Input.is_action_pressed("ui_right"):
			if camera_pivot.rotation_degrees.y > LIMIT_X_MIN :
				rotate_webcam_y(-_pan_speed * delta)
			
	# Check if ears are aligned
	check_hint_range()
	check_ears_aligned()

func check_hint_range():
	var hint_range_mult = 4 #this is the multiplier to know when in range
	if (
		# X axis
		camera_pivot.rotation_degrees.x < (cam_default_pos_x + hint_range_mult * EARS_MARGIN_POS) &&
		camera_pivot.rotation_degrees.x > (cam_default_pos_x - hint_range_mult * EARS_MARGIN_POS) &&
		# Y axis
		camera_pivot.rotation_degrees.y < (cam_default_pos_y + hint_range_mult * EARS_MARGIN_POS) &&
		camera_pivot.rotation_degrees.y > (cam_default_pos_y - hint_range_mult * EARS_MARGIN_POS) &&
		# FOV
		camera.fov < (cam_default_fov + hint_range_mult * EARS_MARGIN_FOV) &&
		camera.fov > (cam_default_fov - hint_range_mult * EARS_MARGIN_FOV)
	) :
		if !is_in_hint_range:
			hint_range_in.emit()
			is_in_hint_range = true
	else :
		if is_in_hint_range:
			hint_range_out.emit()
			is_in_hint_range = false
		
func check_ears_aligned():
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
		if !is_aligned:
			is_aligned = true
			ding_player.play()
			ears_aligned_in.emit()
	else :
		if is_aligned:
			is_aligned = false
			ears_aligned_out.emit()

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
