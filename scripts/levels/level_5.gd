extends Node2D

@export var DIFFICULTY:float = 0.5
@export var timer_wait:float = 0.2
@export var timer_sec:int = 15 + 1

func _on_ready() -> void:
	GameManager.current_level = 5
	
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
	await get_tree().create_timer(timer_wait).timeout
	$Cat6.unalign_camera_random(DIFFICULTY, DIFFICULTY)
	$Cat6.connect_cat()

	$LevelTimer.set_time(timer_sec)
	
	var signal_call = Callable(GameManager, "next_level")
	WebcamManager.all_cats_aligned.connect(signal_call)
	
	# dialogs
	DialogManager.start_dialog(["Welcome to this meeting of 'Catmom yes but Catboss first'."], $Cat1, true)
	await DialogManager.dialog_finish
	DialogManager.start_dialog(["Thank you for organizing this, moments like these are so valuable."], $Cat2, true)
	await DialogManager.dialog_finish
	DialogManager.start_dialog(["Cathreen, you're so right, this space literally changed my life."], $Cat3, true)
	await DialogManager.dialog_finish
	DialogManager.start_dialog(["By the way, I discovered a book recently that really impacted me."], $Cat4, true)
	await DialogManager.dialog_finish
	DialogManager.start_dialog(["Is this the book you told me about?"], $Cat5, true)
	await DialogManager.dialog_finish
	DialogManager.start_dialog(["Yes! From this CEO explaining how they balanced their home and professional life."], $Cat4, true)
	await DialogManager.dialog_finish
	DialogManager.start_dialog(["Let me guess, community and having people around them was invaluable."], $Cat6, true)
	await DialogManager.dialog_finish
	DialogManager.start_dialog(["As we all know ahah."], $Cat1, true)
	await DialogManager.dialog_finish
