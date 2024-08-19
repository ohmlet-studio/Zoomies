extends Node2D

const DIFFICULTY = 0.5

@onready var cat1 = %Cat1
@onready var cat2 = %Cat2
@onready var timer_label = %timer_label
@export var timer_wait = 0.2

@export var timer_sec = 15 + 1

func _on_ready() -> void:
	await get_tree().create_timer(timer_wait).timeout
	cat1.unalign_camera_random(DIFFICULTY, DIFFICULTY)
	cat1.connect_cat()
	await get_tree().create_timer(timer_wait).timeout
	cat2.unalign_camera_random(DIFFICULTY, DIFFICULTY)
	cat2.connect_cat()




func _on_timer_timeout() -> void:
	timer_sec -= 1
	if timer_sec <= 10 :
		var theme_red = load("res://assets/fonts/label_theme_red.tres")
		timer_label.set_theme(theme_red)
	timer_label.text = "00:"+str(timer_sec)
