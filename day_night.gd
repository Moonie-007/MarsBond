extends Node

@export var day_length = 120.0
var time_of_day := 0.0
var current_day := 1
@export var sun: DirectionalLight3D
@export var night_message: Label
var was_night := false
@export var night_message_duration := 6.0

func _process(delta):
	time_of_day += delta
	
	if time_of_day >= day_length:
		time_of_day = 0
		current_day += 1
		print("DAY", current_day, "BEGINS . . . ")
	var progress = time_of_day / day_length
	sun.rotation_degrees.x = lerp(-45.0, 135.0, progress)
	var sun_angle = fmod(sun.rotation_degrees.x, 360)
	if sun_angle < 0:
		sun_angle += 360.0

	var is_night = sun_angle > 180

	if is_night and not was_night:
		night_message.text = "Night has fallen . . . \nReturn to ship . . ."
		night_message.visible = true
		await get_tree().create_timer(night_message_duration).timeout
		night_message.visible = false


		was_night = is_night
