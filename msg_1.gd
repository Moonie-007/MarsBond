extends Label

@export var typing_speed := 0.04
@export var message_delay := 2.0

var messages = [
	"The spaceship has crashed on Mars . . . ",
	"You are the only survivor . . . ",
	"Hostile creatures have been detected . . . ",
	"Dust storms can appear without warning . . . ",
	"You will need food to survive . . . ",
	"Hunt the creatures during the day to find food . . . ",
	"Be careful . . . ",
	"Once night falls, return to the spaceship . . . ",
	"If you go hungry for three nights, you will not survive . . . ",
	"Survive 100 days on Mars to return home . . . "
]

func _ready() -> void:
	play_story()

func play_story():
	for message in messages:
		await type_text(message)
		await get_tree().create_timer(message_delay).timeout

	await type_text("DAY 1 BEGINS . . . ")
	await get_tree().create_timer(2.0).timeout
	text = ""

func type_text(text_to_show: String):
	text = ""
	for letter in text_to_show:
		text += letter
		await get_tree().create_timer(typing_speed).timeout
