extends MarginContainer

@onready var label = $MarginContainer/Label
@onready var timer = $LetterDisplayTimer
@onready var meowplayer = $MeowPlayer

const voice = "B"
const MAX_WIDTH = 1000

var text = ""
var letter_index = 0
var display_all = false

var letter_time = 0.03
var space_time = 0.06
var punctuation_time = 0.2

var text_aggreator = ""
var bubble_position

@export var voice_A: Array[AudioStream]
@export var voice_B: Array[AudioStream]
@export var voice_C: Array[AudioStream]

var sounds = {}

signal finished_displaying()

func _ready():
	sounds['A'] = voice_A
	sounds['B'] = voice_B
	sounds['C'] = voice_C

func display_text(text_to_display: String, position: Vector2):
	text = text_to_display
	bubble_position = position
	_display_letter()


func _play_meow(voice):
	if meowplayer.playing:
		return
	
	var random_sound = sounds[voice][randi() % sounds[voice].size()]
	
	meowplayer.stream = random_sound
	meowplayer.pitch_scale = 1.0 + (randf() * 0.5 - 0.25)
	meowplayer.play()
	
	
func _display_letter():
	text_aggreator += text[letter_index]
	
	label.text = text_aggreator
	
	custom_minimum_size.x = min(size.x, MAX_WIDTH)
		
	# Wrap line if max width reached
	if size.x > MAX_WIDTH:
		label.autowrap_mode = TextServer.AUTOWRAP_WORD
		custom_minimum_size.y = size.y
		
	global_position.x = bubble_position.x - size.x / 2
	global_position.y = bubble_position.y  - size.y + 24
	get_node("Tail").global_position = bubble_position
	
	letter_index += 1
	if letter_index >= text.length():
		finished_displaying.emit()
		display_all = false
		return
	
	if display_all :
		timer.start(0.0001 )
		
	else :
		match text[letter_index]:
			"!", ".", ",", "?":
				timer.start(punctuation_time)
			" ":
				timer.start(space_time)
			_:
				_play_meow(voice)
				timer.start(letter_time)
			
	

func _on_letter_display_timer_timeout() -> void:
	_display_letter()

func _handle_all_letter():
	_display_letter()
