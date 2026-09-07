extends Node3D

@export var open_distance := 2.0
@export var open_speed := 3.0

var is_open := false
var closed_position: Vector3
var open_position: Vector3

@onready var door_body = $StaticBody3D

func _ready():
	closed_position = door_body.position
	open_position = closed_position + Vector3(0, open_distance, 0)

func _process(delta):
	if is_open:
		door_body.position = door_body.position.lerp(open_position, open_speed * delta)
	else:
		door_body.position = door_body.position.lerp(closed_position, open_speed * delta)

func _interact():
	is_open = !is_open
