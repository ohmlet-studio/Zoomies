extends Control

@onready var cat1 = $Cat1
@onready var cat2 = $Cat2
@onready var cat3 = $Cat3
@onready var cat4 = $Cat4
@onready var cat5 = $Cat5
@onready var cat6 = $Cat6

var cat_pos : PackedVector2Array
var cat_default_pos : PackedVector2Array

var cat_array : Array

var incr = Vector2(1,1)
var decr = Vector2(-1,-1)
var incr_max = 0

const MAX = 50

func _ready() -> void:
	cat_array = [cat1, cat2, cat3, cat4, cat5, cat6]
	var idx = 0
	for cat in cat_array :
		cat_pos.append(cat.position)
	cat_default_pos = cat_pos


func _process(delta : float) -> void :
	#var rand_idx = 0
	##cat_array[rand_idx].set_position(cat_array[rand_idx].position + incr)
	#incr_max = 0
	#set_process(false)
	#while true:
		#if incr_max < MAX :
			#cat_array[rand_idx].set_position(cat_array[rand_idx].position + incr)
			#incr_max += 1
		#else :
			#cat_array[rand_idx].set_position(cat_array[rand_idx].position + decr)
			#print("here")
			#
		#if cat_array[rand_idx].position ==  cat_default_pos[rand_idx]:
			#break
	#set_process(true)
	pass
