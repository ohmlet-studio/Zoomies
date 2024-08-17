extends Node2D

const lines: Array[String] = [
	"Bonjour, je m'appelle Truc. Et je suis contengue !",
	"Test ! Test !",
	"Et la voila je fais ça !",
]

const test_position = Vector2(500, 500)

func _unhandeld_input(event):
	print("HEEEEErE")
	if event.is_action_pressed("start_dialog"):
		print("HERE")
		DialogManager.start_dialog(test_position, lines)


func _on_ready() -> void:
	print("HEEEEErE")
	DialogManager.start_dialog(test_position, lines)
