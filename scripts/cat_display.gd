extends Node2D

@onready var nine_patch = $NinePatchRect
@onready var sprite = $CatDisplaySprite
@onready var sub_viewport = $SubViewport

@export var default_boder_color = Color("d7d7d7")
@export var border_color_focus = Color("Green")
@export var border_color_hover = Color("white")

var border_color = default_boder_color


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sprite.texture = sub_viewport.get_texture()
	sub_viewport.render_target_update_mode = SubViewport.UPDATE_ONCE
	$connect_sound.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	nine_patch.modulate = border_color
	

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
	border_color = Color("Green")
	await get_tree().create_timer(1).timeout
	sub_viewport.is_active = false
	sub_viewport.render_target_update_mode = SubViewport.UPDATE_ONCE
	border_color = Color("#d7d7d7")
