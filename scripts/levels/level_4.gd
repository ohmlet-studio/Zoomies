extends Node2D

const DIFFICULTY = 0.5

@onready var cat1 = %Cat1
@onready var cat2 = %Cat2
@onready var cat3 = %Cat3
@onready var cat4 = %Cat4
@onready var cat5 = %Cat5

@export var timer_wait = 0.2

func _on_ready() -> void:
	await get_tree().create_timer(timer_wait).timeout
	cat1.unalign_camera_random(DIFFICULTY, DIFFICULTY)
	cat1.connect_cat()
	await get_tree().create_timer(timer_wait).timeout
	cat2.unalign_camera_random(DIFFICULTY, DIFFICULTY)
	cat2.connect_cat()
	await get_tree().create_timer(timer_wait).timeout
	cat3.unalign_camera_random(DIFFICULTY, DIFFICULTY)
	cat3.connect_cat()
	await get_tree().create_timer(timer_wait).timeout
	cat4.unalign_camera_random(DIFFICULTY, DIFFICULTY)
	cat4.connect_cat()
	await get_tree().create_timer(timer_wait).timeout
	cat5.unalign_camera_random(DIFFICULTY, DIFFICULTY)
	cat5.connect_cat()
