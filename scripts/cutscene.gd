extends Node2D

@export var number_of_floors:int = 10
@export var floor_scroll_time:float = 0.2
@export var gameover = false

@onready var score_label = %ScoreLabel
@onready var letter_node = %Letter_node
@onready var yesno_node = %YesNo_node
@onready var letter_anim = %letterAnim
@onready var yesno_anim = %yesnoAnim

var target_scale_y = Vector2(1, 1)
var first_floor_height = 70
var midsection_height

var tick_timer
var tick_count = 0
var score = 0

signal cutscene_over()

func _ready():
	number_of_floors -= 2
	midsection_height = $midsections/building_mid.get_rect().size.y * 0.95
	
	# if gameover do not play the animation
	var target_camera_y
	if gameover:
		var midsection = $midsections.get_child(number_of_floors % 3).duplicate()
		var roof = $Building_roof
		midsection.position.y = -first_floor_height + -(number_of_floors-1) * midsection_height
		midsection.position.x = (number_of_floors % 3 - 1) * 50
		$Camera2D.offset.y = -first_floor_height + -number_of_floors * midsection_height
		target_camera_y = 0
		roof.position.y = $Camera2D.offset.y - 100
		add_child(midsection)
		
	else:
		$Camera2D.offset.y = 0
		target_camera_y = -first_floor_height + -number_of_floors * midsection_height
	
	# if less than one floor
	if number_of_floors < 1:
		$Victory.play()
		await get_tree().create_timer(2.5).timeout
		cutscene_over.emit()
		return
	
	for i in range(number_of_floors-1):
		# Get the midsection (floor - 1) % 3
		var midsection_index = (i - 1) % 3
		var midsection = $midsections.get_child(midsection_index).duplicate()
		midsection.position.y = -first_floor_height + -i * midsection_height
		midsection.position.x = (i % 3 - 1) * 50
		self.add_child(midsection)

	# wait a bit
	$Victory.play()
	await get_tree().create_timer(2.5).timeout
	
	var tween_camera_move = get_tree().create_tween()
	tween_camera_move.tween_property($Camera2D, "offset:y", target_camera_y, floor_scroll_time*number_of_floors)
	tween_camera_move.set_ease(Tween.EASE_IN_OUT)

	if !gameover:
		tween_camera_move.tween_callback(_spawn_last_level)
	#else:
		#print("bottom reached")
		#cutscene_over.emit()
	
	# create a timer and play tick sound every floor_scroll_time s
	tick_timer = Timer.new()
	tick_timer.wait_time = floor_scroll_time
	tick_timer.autostart = true
	tick_timer.one_shot = false
	add_child(tick_timer)
	tick_timer.connect("timeout", _on_Timer_timeout)

func _on_Timer_timeout():
	if tick_count < number_of_floors:
		$Building_tick.play()
		tick_count += 1
		if gameover :
			score_label.text = "Score : " + str(score)
			score += 1
			if score == GameManager.current_level :
				await get_tree().create_timer(2.5).timeout
				print("bottom reached")
				cutscene_over.emit()
				letter_node.visible = true
				yesno_node.visible = true
				letter_anim.play("youre_fired_anim")
				yesno_anim.play("yes_no_anim")
				
				
	else:
		tick_timer.stop() # Stop the timer after 10 ticks
			
func _spawn_last_level():
	var tween_building_pop = get_tree().create_tween()
	
	var midsection = $midsections.get_child(number_of_floors % 3).duplicate()
	midsection.position.y = -first_floor_height + -(number_of_floors-1) * midsection_height
	midsection.position.x = (number_of_floors % 3 - 1) * 50
	midsection.scale = Vector2(0., 0.)
	add_child(midsection)
	tween_building_pop.tween_property(midsection, "scale", target_scale_y, 0.2).set_trans(Tween.TRANS_SINE)
	tween_building_pop.tween_callback(_spawn_roof)

func _spawn_roof():
	# Spawn roof on top of all floors
	play_pop()
	
	var tween_roof_pop = get_tree().create_tween()
	var roof = $Building_roof
	roof.position.y = -first_floor_height + -(number_of_floors) * midsection_height - 100
	roof.scale = Vector2(0., 0.)
	
	tween_roof_pop.tween_property(roof, "scale", target_scale_y, 0.2).set_trans(Tween.TRANS_SINE)
	tween_roof_pop.tween_callback(play_pop)

func play_pop():
	$Building_pop_sound.play()
	await get_tree().create_timer(1).timeout
	cutscene_over.emit()


func _on_yes_pressed() -> void:
	self.queue_free()
	GameManager.restart_level()


func _on_no_pressed() -> void:
	self.queue_free()
	get_tree().change_scene_to_file("res://scenes/ui/main_menu.tscn")
