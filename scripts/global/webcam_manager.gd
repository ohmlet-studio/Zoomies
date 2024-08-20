extends Node

var cat_displays: Array[Node2D] = []

signal all_cats_aligned()

func check_are_cats_aligned() -> void:
	if cat_displays.size() >= 2:
		for cat_display in cat_displays:
			if !cat_display.is_aligned():
				return
	
		all_cats_aligned.emit()

func reset_cats():
	cat_displays = []

func add_new_display(display: Node2D) -> void:
	# Add the display to the list
	display.move_room(cat_displays.size())
	cat_displays.append(display)
	
	if cat_displays.size() == 1:
		change_focus(display)
	
func change_focus(display: Node2D) -> void:
	# Call activate on the passed display and deactivate on all others in the list
	for cat_display in cat_displays:
		if cat_display == display:
			cat_display.activate()
		else:
			cat_display.deactivate()

func update_all_one_frame() -> void:
	# Call update_once on all displays
	for cat_display in cat_displays:
		cat_display.update_once()

func pause_all() -> void:
	# Call deactivate on all displays
	for cat_display in cat_displays:
		cat_display.deactivate()

func random_display() -> Node2D:
	# Return a random element from the list
	if cat_displays.size() > 0:
		return cat_displays[randi() % cat_displays.size()]
	else:
		return null

func get_display(index: int) -> Node2D:
	# Get display from index
	if index >= 0 and index < cat_displays.size():
		return cat_displays[index]
	else:
		return null
		
func disconnect_all() -> void:
	# Call deactivate on all displays
	for cat_display in cat_displays:
		cat_display.disconnect_cat()
