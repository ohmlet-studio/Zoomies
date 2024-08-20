extends Timer

@export var timer_sec:int = 10

func _on_timer_timeout() -> void:
	timer_sec -= 1
	if timer_sec <= 10:
		var theme_red = load("res://assets/fonts/label_theme_red.tres")
		$timer_label.set_theme(theme_red)
	
	# Calculate minutes and seconds
	var minutes = int(timer_sec / 60)
	var seconds = timer_sec % 60
	
	# Format the time as MM:SS
	$timer_label.text = str(minutes).pad_zeros(2) + ":" + str(seconds).pad_zeros(2)
	
	GameManager.game_over()

func set_time(seconds: int):
	self.timer_sec = seconds
