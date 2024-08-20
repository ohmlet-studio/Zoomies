extends Node2D

@export var DIFFICULTY:float = 0.5
@export var timer_wait:float = 0.2
@export var timer_sec:int = 15 + 1

func _on_ready() -> void:
	GameManager.current_level = 3
	
	await get_tree().create_timer(timer_wait).timeout
	$Cat1.unalign_camera_random(DIFFICULTY, DIFFICULTY)
	$Cat1.connect_cat()
	await get_tree().create_timer(timer_wait).timeout
	$Cat2.unalign_camera_random(DIFFICULTY, DIFFICULTY)
	$Cat2.connect_cat()
	await get_tree().create_timer(timer_wait).timeout
	$Cat3.unalign_camera_random(DIFFICULTY, DIFFICULTY)
	$Cat3.connect_cat()
	await get_tree().create_timer(timer_wait).timeout
	$Cat4.unalign_camera_random(DIFFICULTY, DIFFICULTY)
	$Cat4.connect_cat()

	$LevelTimer.set_time(timer_sec)
	var signal_call = Callable(GameManager, "next_level")
	WebcamManager.all_cats_aligned.connect(signal_call)
	
	# dialogs
	DialogManager.start_dialog(["Is everyone here ?"], $Cat1, true)
	await DialogManager.dialog_finish
	DialogManager.start_dialog(["I think so? I'm not sure I can see everyone clearly though?"], $Cat2, true)
	await DialogManager.dialog_finish
	DialogManager.start_dialog(["I might have some mic issues, I've had some troubles with it lately..."], $Cat3, true)
	await DialogManager.dialog_finish
	DialogManager.start_dialog(["I'm so excited to start this meeting!"], $Cat4, true)
	await DialogManager.dialog_finish
	DialogManager.start_dialog(["So the main order of business today is the logistics for the annual fishercats meeting in 2 months."], $Cat2, true)
	await DialogManager.dialog_finish
	DialogManager.start_dialog(["I'm working on installing a pond inside the venue."], $Cat3, true)
	await DialogManager.dialog_finish
	DialogManager.start_dialog(["By the way, I'm in touch with a rare fish provider so we can catch some fun stuff!"], $Cat1, true)
	await DialogManager.dialog_finish
	DialogManager.start_dialog(["Amazing, that's great!"], $Cat4, true)
	await DialogManager.dialog_finish
	DialogManager.start_dialog(["The guests have mostly confirmed their presence, I'm still waiting on a few answers."], $Cat2, true)
	await DialogManager.dialog_finish
	DialogManager.start_dialog(["I've heard that Glarfield might come!"], $Cat4, true)
	await DialogManager.dialog_finish
	DialogManager.start_dialog(["I can't say anything for sure yet, but I'll let you know eheh..."], $Cat2, true)
	await DialogManager.dialog_finish
