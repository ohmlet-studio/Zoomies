extends Node2D

@export var DIFFICULTY:float = 0.5
@export var timer_wait:float = 0.2
@export var timer_sec:int = 15 + 1

func _on_ready() -> void:
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
