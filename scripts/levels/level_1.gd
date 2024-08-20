extends Node2D

@export var DIFFICULTY:float = 0.5
@export var timer_wait:float = 0.2
@export var timer_sec:int = 15 + 1

func _on_ready() -> void:
	GameManager.current_level = 1
	
	await get_tree().create_timer(timer_wait).timeout
	$Cat1.unalign_camera_random(DIFFICULTY, DIFFICULTY)
	$Cat1.connect_cat()
	await get_tree().create_timer(timer_wait).timeout
	$Cat2.unalign_camera_random(DIFFICULTY, DIFFICULTY)
	$Cat2.connect_cat()
	
	$LevelTimer.set_time(timer_sec)
	
	var signal_call = Callable(GameManager, "next_level")
	WebcamManager.all_cats_aligned.connect(signal_call)
	
	# dialogs
	DialogManager.start_dialog(["Hey thanks for calling !     "], $Cat1, true)
	await DialogManager.dialog_finish
	DialogManager.start_dialog(["No worries love !     "], $Cat2, true)
	await DialogManager.dialog_finish
	DialogManager.start_dialog(["I know you don't like video calls...     "], $Cat1, true)
	await DialogManager.dialog_finish
	DialogManager.start_dialog(["Yeah I always feel uneasy, like someone is watching.     "], $Cat2, true)
	await DialogManager.dialog_finish
	DialogManager.start_dialog(["Ahahah, that's irrational you know there's no way !     "], $Cat1, true)
	await DialogManager.dialog_finish
	DialogManager.start_dialog(["Yeah, yeah, and what would they even see anyway ?     "], $Cat2, true)
	await DialogManager.dialog_finish
	DialogManager.start_dialog(["So, how are you ?     "], $Cat1, true)
	await DialogManager.dialog_finish
	DialogManager.start_dialog(["Life you know, my boss was an ass as usual... How are you ?     "], $Cat2, true)
	await DialogManager.dialog_finish
	DialogManager.start_dialog(["I'm fine, I really miss you.     "], $Cat1, true)
