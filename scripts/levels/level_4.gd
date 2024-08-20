extends Node2D

@export var DIFFICULTY:float = 0.5
@export var timer_wait:float = 0.2
@export var timer_sec:int = 15 + 1

func _on_ready() -> void:
	GameManager.current_level = 4
	
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
	await get_tree().create_timer(timer_wait).timeout
	$Cat5.unalign_camera_random(DIFFICULTY, DIFFICULTY)
	$Cat5.connect_cat()

	$LevelTimer.set_time(timer_sec)

	var signal_call = Callable(GameManager, "next_level")
	WebcamManager.all_cats_aligned.connect(signal_call)
	
	# dialogs
	DialogManager.start_dialog(["Hey guys can everyone hear me?"], $Cat1, true)
	await DialogManager.dialog_finish
	DialogManager.start_dialog(["Yes!"], $Cat2, true)
	await DialogManager.dialog_finish
	DialogManager.start_dialog(["Yes!"], $Cat5, true)
	await DialogManager.dialog_finish
	DialogManager.start_dialog(["Does anyone have any idea what we're getting Felix?"], $Cat2, true)
	await DialogManager.dialog_finish
	DialogManager.start_dialog(["I was thinking high quality treats or something like that."], $Cat3, true)
	await DialogManager.dialog_finish
	DialogManager.start_dialog(["He's something of a connoisseur, he would love that!"], $Cat4, true)
	await DialogManager.dialog_finish
	DialogManager.start_dialog(["You're forgetting he's a brand ambassador, he always gets food and treats..."], $Cat5, true)
	await DialogManager.dialog_finish
	DialogManager.start_dialog(["Yup, completely forgot, so are we thinking game, clothes?"], $Cat3, true)
	await DialogManager.dialog_finish
	DialogManager.start_dialog(["I was more 'experience' oriented!"], $Cat1, true)
	await DialogManager.dialog_finish
	DialogManager.start_dialog(["I had a pottery class recently and actually loved it!!"], $Cat4, true)
	await DialogManager.dialog_finish
	DialogManager.start_dialog(["It's so fulfilling creating things with your paws."], $Cat2, true)
	await DialogManager.dialog_finish
