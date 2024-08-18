extends Node2D

const lines: Array[String] = [
	"Bonjour, je m'appelle Truc. Et je suis contengue !",
	"Test ! Test !",
	"Et la voila je fais ça !",
]

const test_position = Vector2(960, 250)

func _on_ready() -> void:
	DialogManager.start_dialog(test_position, lines)
