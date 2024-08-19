extends SubViewport

var is_active = false
var _pan_speed: float = 1
var _zoom_speed: float = 1

@onready var camera = $world/WebcamPivot/Camera3D;
@onready var camera_pivot = $world/WebcamPivot

var is_aligned = false

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
