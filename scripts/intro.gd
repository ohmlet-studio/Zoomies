extends Node2D

const lines: Array[String] = [
	"So, this is your first day at zoomies ?",
	"Welcome to the family...",
	"As a new member of our family.",
	"You have the responsibility of making us look good.",
	"You see, we may have fast tracked the production process...",
	"And our product was maybe not entirely...",
	"… built to scale ya know.",
	"These days we provide a video call software.",
	"And contrary to what we advertised.",
	"We didn't have the time to code an AI to make sure everyone is in frame.",
	"so it's your job now.",
	"We know you have no coding skills.",
	"You're way cheaper than a dev ahah.",
	"You're gonna have to manually correct the bug.",
	"If you're not fast enough people will notice.",
	"Then zoomies' reputation will suffer.",
	"Which is not good...",
	"… for you.",
	"I'll show you how to properly do your job."
]

const test_position = Vector2(960, 250)

func _on_ready() -> void:
	DialogManager.start_dialog(test_position, lines)
