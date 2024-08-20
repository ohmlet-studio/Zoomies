extends Node

var current_level = 1

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
	
	remove_child(gameover_instance)

	# TODO switch to letter scene 
	
func unlock_infinite_mode():
	pass #TODO
