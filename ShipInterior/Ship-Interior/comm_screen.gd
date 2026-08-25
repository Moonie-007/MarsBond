extends Node3D

@onready var viewport = $ScreenViewport
@onready var call_ui = $ScreenViewport/CallUI
@onready var message_label = $ScreenViewport/CallUI/MsgLabel
@onready var static_overlay = $ScreenViewport/CallUI/StaticOverlay
@onready var audio_player = $CallAudio
@onready var screen_mesh = $ScreenMesh
@onready var proximity_area = $ProximityArea

var is_on = false
var call_timer = 0.0
var next_call_time = 30.0
var player_in_range = false

var messages = [

func _ready():
	messages.append("Daddy? When are you coming home?")
	messages.append("Mom says the garden is greener than ever... I miss you.")
	messages.append("Timmy drew a rocket today. It had a big round thing on the side...")
	messages.append("We saw a shooting star. I wished you were here.")
	messages.append("The power went out last night. We lit candles.")
	messages.append("I am not scared! You said astronauts are brave!")
	messages.append("Where are you? Is it cold there?")

	call_ui.visible = false
	static_overlay.visible = false
	set_screen_glow(0.0)
	proximity_area.body_entered.connect(_on_body_entered)
	proximity_area.body_exited.connect(_on_body_exited) ]

func _process(delta):
	if not is_on and player_in_range:
	call_timer += delta
	if call_timer >= next_call_time:
	trigger_call()

func _on_body_entered(body):
	if body.is_in_group("player"):
 player_in_range = true

func _on_body_exited(body):
	if body.is_in_group("player"):
 player_in_range = false

func trigger_call():
	is_on = true
	call_timer = 0.0
	call_ui.visible = true
	static_overlay.visible = true
	set_screen_glow(1.5)

	var msg = messages.pick_random()
	message_label.text = msg

	if audio_player.stream:
 audio_player.play()

	var tween = create_tween()
	tween.tween_property(static_overlay, "modulate:a", 0.3, 0.5)
	tween.tween_property(static_overlay, "modulate:a", 0.1, 0.3)
	tween.set_loops(5)

	await get_tree().create_timer(12.0).timeout
	end_call()

func end_call():
	is_on = false
	call_ui.visible = false
	static_overlay.visible = false
	set_screen_glow(0.0)
	audio_player.stop()
	next_call_time = randf_range(60, 180)
	call_timer = 0.0

func set_screen_glow(energy):
	var mat = screen_mesh.get_active_material(0)
	if mat:
 mat.emission_energy_multiplier = energy
