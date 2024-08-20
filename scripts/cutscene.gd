extends Node2D

@export var number_of_floors:int = 15
@export var floor_scroll_time:float = 0.2

var target_scale_y = Vector2(1, 1)
var midsection_height
var first_floor_height

var tick_timer
var tick_count = 0


func _ready():
	if number_of_floors < 1:
		$Victory.play()
		await get_tree().create_timer(3).timeout
		return
		
		
	midsection_height = $midsections/building_mid.get_rect().size.y * 0.95
	first_floor_height = 70
	
	for i in range(number_of_floors-1):
		# Get the midsection (floor - 1) % 3
		var midsection_index = (i - 1) % 3
		var midsection = $midsections.get_child(midsection_index).duplicate()
		midsection.position.y = -first_floor_height + -i * midsection_height
		midsection.position.x = (i % 3 - 1) * 50
		self.add_child(midsection)
	
	# wait a bit
	$Victory.play()
	await get_tree().create_timer(3).timeout
	
	$Camera2D.offset.y = 0
	var target_camera_y = -first_floor_height + -number_of_floors * midsection_height
	var tween_camera_move = get_tree().create_tween()
	tween_camera_move.tween_property($Camera2D, "offset:y", target_camera_y, floor_scroll_time*number_of_floors)
	tween_camera_move.set_ease(Tween.EASE_IN_OUT)
	tween_camera_move.tween_callback(_spawn_last_level)
	
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
