extends Node2D

# Load the custom images for the mouse cursor
var cursor = load("res://assets/textures/UI/cursor.png")
var hover = load("res://assets/textures/UI/cursorhover.png")

func _mouse():
	# Changes only the arrow shape of the cursor
	# This is similar to changing it in the project settings
	Input.set_custom_mouse_cursor(hover)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
