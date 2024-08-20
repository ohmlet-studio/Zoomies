extends Node2D

const dialog_one: Array[String] = [
	"Ok try to find me in the room using WASD to move around and simultaneously hold SHIFT to zoom in or out."
]

const dialog_two: Array[String] = [
	"Look around until my head in is frame."
]

const dialog_getting_closer: Array[String] = [
	"Now, match the ears to the outline.",
	"quickly, preferably..."
]

const dialog_tutorial_over: Array[String] = [
	"I think you get the jist of it.",
	"Good luck now!",
]

var handle_dial_finish : Callable

var next_dialog_step = "start"

func _ready() -> void:
	WebcamManager.reset_cats()
	
	await get_tree().create_timer(0.5).timeout
	
	$Boss.connect_cat(true)
	
	await get_tree().create_timer(0.5).timeout
	
	var dialog_signal_call = Callable(self, "_on_dialog_finish")
	DialogManager.dialog_finish.connect(dialog_signal_call)
	DialogManager.start_dialog(dialog_one, $Boss)

func _on_dialog_finish():
	# when dialog is over
	
	if next_dialog_step == "start":
		await get_tree().create_timer(.5).timeout
		$sfx.play()
		$Boss.unalign_camera_random(1, 0.5)
		
		$Boss.set_cinematic_mode(false)
		$Boss.enable_input()
		$Boss.activate()
		
		next_dialog_step = "step_two"
		
	elif next_dialog_step == "step_two":
		await get_tree().create_timer(.5).timeout
		DialogManager.start_dialog(dialog_two, $Boss)
		next_dialog_step = ""
		
	elif next_dialog_step == "last_step":
		$Boss.disconnect_cat()
		await get_tree().create_timer(0.5).timeout
		
		# start level 1
		WebcamManager.reset_cats()
		get_tree().change_scene_to_file("res://scenes/levels/level_1.tscn")
		
	elif next_dialog_step == "unlock_controls":
		$Boss.enable_input()
		$Boss.activate()

func getting_closer():
	next_dialog_step = "unlock_controls"
	$Boss.disable_input()
	DialogManager.start_dialog(dialog_getting_closer, $Boss)
	
func finish_tutorial():
	next_dialog_step = "last_step"
	$Boss.set_cinematic_mode(true)
	DialogManager.start_dialog(dialog_tutorial_over, $Boss)
