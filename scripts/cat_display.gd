extends Node2D

@onready var nine_patch = $NinePatchRect
var border_color = Color("green")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$CatDisplaySprite.texture = $SubViewport.get_texture()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	nine_patch.modulate = border_color
