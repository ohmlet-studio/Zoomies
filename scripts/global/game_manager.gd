extends Node

var current_level = 1

var infinite_score = 0
var infinite_timer

# ce script gère les transitions entre niveaux (cutscene, gameover, dialogues, etc.)
func next_level():
	await get_tree().create_timer(1).timeout

	get_tree().current_scene.free()
	
	# Load the cutscene scene and wait for it to finish by listening to "cutscene_over" signal
	var cutscene_scene = load("res://scenes/cutscenes/cutscene.tscn")
	var cutscene_instance = cutscene_scene.instantiate()
	cutscene_instance.number_of_floors = current_level + 3
	
	add_child(cutscene_instance)
	await cutscene_instance.cutscene_over
	
	remove_child(cutscene_instance)

	# Increment the current level
	current_level += 1
	
	# Reset the webcam cats
	WebcamManager.reset_cats()

	var next_scene_path = "res://scenes/levels/level_%d.tscn" % current_level

	if ResourceLoader.exists(next_scene_path):
		get_tree().change_scene_to_file(next_scene_path)
	else:
		unlock_infinite_mode()
		get_tree().change_scene_to_file("res://scenes/levels/level_infinite.tscn")

func restart_level():
	await get_tree().create_timer(0.5).timeout
	WebcamManager.reset_cats()
	get_tree().change_scene_to_file(str("res://scenes/levels/level_",current_level,".tscn"))
	
func game_over():
	
	await get_tree().create_timer(1).timeout

	get_tree().current_scene.free()
	
	# Load the cutscene scene and wait for it to finish by listening to "cutscene_over" signal
	var gameover_scene = load("res://scenes/cutscenes/game_over_all.tscn")
	var gameover_instance = gameover_scene.instantiate()
	gameover_instance.number_of_floors = current_level + 3
	
	add_child(gameover_instance)
	await gameover_instance.cutscene_over
	
	#gameover_instance.Letter_node.AnimationPlayer.play("youre_fired_anim")
	#remove_child(gameover_instance)
	
	# TODO switch to letter scene 

func set_infinte_timer(timer):
	self.infinite_timer = timer

func add_time_infinite_mode():
	print("gegeges")
	var time = self.infinite_timer.time_left + 5
	self.infinite_timer.wait_time = time
	
func add_to_score_infinite_mode():
	infinite_score += 0.2
	current_level = int(infinite_score)
	

func unlock_infinite_mode():
	pass #TODO
