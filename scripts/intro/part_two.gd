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

var handle_dial_finish : Callable

var dialog_step = 0

func _ready() -> void:
	WebcamManager.reset()
	await get_tree().create_timer(.5).timeout
	
	$Boss.connect_cat()
	$Boss.disable_input()
	
	await get_tree().create_timer(.5).timeout

	var dialog_signal_call = Callable(self, "_on_dialog_finish")
	DialogManager.dialog_finish.connect(dialog_signal_call)
	DialogManager.start_dialog(dialog_one, $Boss)

func _on_dialog_finish():
	# when dialog is over
	
	dialog_step += 1
	
	if dialog_step == 1:
		await get_tree().create_timer(.5).timeout
		$Boss.enable_input()
		$sfx.play()
		$Boss.unalign_camera_random(0.5, 0.5)
		DialogManager.start_dialog(dialog_two, $Boss)
	elif dialog_step == 2:
		DialogManager.start_dialog(dialog_three, $Boss)
	else:
		pass
