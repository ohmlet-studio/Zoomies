extends Node2D

const dialog_one: Array[String] = [
	"Ok try to find me in the room using WASD and SHIFT"
]

const dialog_two: Array[String] = [
	"Look around until my head in is frame."
]

const dialog_three: Array[String] = [
	"Now, match the ears to the outline.",
	"quickly, preferably..."
]

const test_position = Vector2(960, 250)

var handle_dial_finish : Callable

func _ready() -> void:
	$Boss.connect_cat()
	$Boss.disable_input()

	var dialog_signal_call = Callable(self, "_on_first_dialog_finish")
	DialogManager.dialog_finish.connect(dialog_signal_call)
	DialogManager.start_dialog(test_position, dialog_one)

func _on_first_dialog_finish():
	await get_tree().create_timer(1).timeout
	
	# when dialog is over
	$Boss.enable_input()
	$sfx.play()
	
	$Boss.unalign_camera_random(0.5, 0.5)
	
	var dialog_signal_call = Callable(self, "_on_second_dialog_finish")
	DialogManager.dialog_finish.connect(dialog_signal_call)
	DialogManager.start_dialog(test_position, dialog_two)

func _on_second_dialog_finish():
	var dialog_signal_call = Callable(self, "_on_third_dialog_finish")
	DialogManager.dialog_finish.connect(dialog_signal_call)
	DialogManager.start_dialog(test_position, dialog_three)
	
func _on_third_dialog_finish():
	DialogManager.start_dialog(test_position, dialog_three)
