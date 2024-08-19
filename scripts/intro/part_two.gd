extends Node2D

const lines: Array[String] = [
	"This is the second dialog"
]

const test_position = Vector2(960, 250)

var handle_dial_finish : Callable

func _ready() -> void:
	$Boss.connect_cat()
	$Boss.disable_input()

	DialogManager.start_dialog(test_position, lines)
	
	await get_tree().create_timer(1).timeout
	
	# when dialog is over
	$Boss.enable_input()
	$sfx.play()
	
	$Boss.unalign_camera_random(0.5, 0.5)
	
