extends Camera3D

var _pan_speed: float = 0.1
var _zoom_speed: float = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _process(delta: float) -> void:
	if Input.is_action_pressed("ui_shift"):
		if Input.is_action_pressed("ui_up"):
			zoom(-_zoom_speed)
		elif Input.is_action_pressed("ui_down"):
			zoom(_zoom_speed)
	else:
		if Input.is_action_pressed("ui_up"):
			pan_y(_pan_speed)
		elif Input.is_action_pressed("ui_down"):
			pan_y(-_pan_speed)
		
		if Input.is_action_pressed("ui_left"):
			pan_x(-_pan_speed)
		elif Input.is_action_pressed("ui_right"):
			pan_x(_pan_speed)

#TODO + sound ?

func zoom(speed) -> void:
	fov += speed
	
	if speed < 0:
		if not get_node("zoomInPlayer").is_playing():
			get_node("zoomInPlayer").playing = true
	else:
		if not get_node("zoomOutPlayer").is_playing():
			get_node("zoomOutPlayer").playing = true


func pan_x(speed) -> void:
	position.x += speed * fov * 0.01
	
	if not get_node("scrollPlayer").is_playing():
		get_node("scrollPlayer").playing = true

func pan_y(speed) -> void:
	position.y += speed * fov * 0.01
	
	if not get_node("scrollPlayer").is_playing():
		get_node("scrollPlayer").playing = true
