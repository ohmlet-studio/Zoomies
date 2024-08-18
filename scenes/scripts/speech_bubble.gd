extends MarginContainer

@onready var label = $MarginContainer/Label
@onready var timer = $LetterDisplayTimer


const MAX_WIDTH = 400

var text = ""
var letter_index = 0

var letter_time = 0.03
var space_time = 0.06
var punctuation_time = 0.2

var text_aggreator = ""
var bubble_position

signal finished_displaying()

func display_text(text_to_display: String, position: Vector2):
	text = text_to_display
	bubble_position = position
	_display_letter()
	
func _display_letter():
	text_aggreator += text[letter_index]
	
	label.text = text_aggreator
	
	custom_minimum_size.x = min(size.x, MAX_WIDTH)
	
	print(size.x)
	
	#Wrap line if max width reached
	if size.x > MAX_WIDTH:
		label.autowrap_mode = TextServer.AUTOWRAP_WORD
		custom_minimum_size.y = size.y
		
	global_position.x = bubble_position.x - size.x / 2
	global_position.y = bubble_position.y  - size.y + 24
	get_node("Tail").global_position = bubble_position
	
	letter_index += 1
	if letter_index >= text.length():
		finished_displaying.emit()
		return
		
	match text[letter_index]:
		"!", ".", ",", "?":
			timer.start(punctuation_time)
		" ":
			timer.start(space_time)
		_:
			timer.start(letter_time)
			



func _on_letter_display_timer_timeout() -> void:
	_display_letter()