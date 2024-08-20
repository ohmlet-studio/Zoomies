extends Node2D

const lines: Array[String] = [
	"So, this is your first day at zoomies ?",
	"Welcome to the family...",
	"As a new member of our family,",
	"you have the responsibility of making us look good.",
	"You see, we may have fast tracked the production process...",
	"And our product was maybe not entirely...",
	"...built to scale ya know.",
	"These days we provide a video call software.",
	"And contrary to what we advertised.",
	"We didn't have the time to code an AI to make sure everyone is in frame.",
	"So it's your job now.",
	"We know you have no coding skills.",
	"You're way cheaper than a dev ahah.",
	"You're gonna have to manually correct the bug.",
	"If you're not fast enough people will notice.",
	"Then zoomies' reputation will suffer.",
	"Which is not good...",
	"...for you.",
	"I'll show you how to properly do your job."
]

func _ready() -> void:
	WebcamManager.reset_cats()
	
	# wait for a bit
	await get_tree().create_timer(0.5).timeout
	
	$Boss.disable_input()
	$Boss.set_cinematic_mode(true)
	$Boss.connect_cat()
	
	await get_tree().create_timer(0.5).timeout
	
	# Connect signal from dialog manager
	var dialog_signal_call = Callable(self, "_on_dialog_finished")
	DialogManager.dialog_finish.connect(dialog_signal_call)
	# Start dialog
	DialogManager.start_dialog(lines, $Boss)
	
	
func _on_dialog_finished():
	$Boss.disconnect_cat()
	
	await get_tree().create_timer(0.5).timeout
	get_tree().change_scene_to_file("res://scenes/intro/part_two.tscn")
