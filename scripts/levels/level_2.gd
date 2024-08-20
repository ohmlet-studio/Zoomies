extends Node2D

@export var DIFFICULTY:float = 0.5
@export var timer_wait:float = 0.2
@export var timer_sec:int = 15 + 1

func _on_ready() -> void:
	GameManager.current_level = 2
	
	await get_tree().create_timer(timer_wait).timeout
	$Cat1.unalign_camera_random(DIFFICULTY, DIFFICULTY)
	$Cat1.connect_cat()
	await get_tree().create_timer(timer_wait).timeout
	$Cat2.unalign_camera_random(DIFFICULTY, DIFFICULTY)
	$Cat2.connect_cat()
	await get_tree().create_timer(timer_wait).timeout
	$Cat3.unalign_camera_random(DIFFICULTY, DIFFICULTY)
	$Cat3.connect_cat()

	$LevelTimer.set_time(timer_sec)
	
	var signal_call = Callable(GameManager, "next_level")
	WebcamManager.all_cats_aligned.connect(signal_call)
	
	# dialogs
	DialogManager.start_dialog(["Hi guys !!!     "], $Cat1, true)
	await DialogManager.dialog_finish
	DialogManager.start_dialog(["Hey chat !!!!     "], $Cat2, true)
	await DialogManager.dialog_finish
	DialogManager.start_dialog(["Today we're with MouseDestroyer69 and CuriosityKilled !     "], $Cat3, true)
	await DialogManager.dialog_finish
	DialogManager.start_dialog(["Yeah, thanks for having us Shroedie.     "], $Cat2, true)
	await DialogManager.dialog_finish
	DialogManager.start_dialog(["You rule my puss.     "], $Cat1, true)
	await DialogManager.dialog_finish
	DialogManager.start_dialog(["Today we're together to try a game by Ohmlet studio.     "], $Cat3, true)
	await DialogManager.dialog_finish
	DialogManager.start_dialog(["Something about a Pug ??? I don't really get it ahah.     "], $Cat1, true)
	await DialogManager.dialog_finish
	DialogManager.start_dialog(["So you're the owner of this pug who wants more treats ?     "], $Cat2, true)
	await DialogManager.dialog_finish
	DialogManager.start_dialog(["Exactly and in order to get them he trains you to plan a heist !     "], $Cat3, true)
	await DialogManager.dialog_finish
	DialogManager.start_dialog(["I never thought a dog could be that smart lol.     "], $Cat2, true)
	await DialogManager.dialog_finish
	DialogManager.start_dialog(["Ahah good one bro !     "], $Cat1, true)
	await DialogManager.dialog_finish
