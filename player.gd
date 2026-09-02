
extends CharacterBody3D

@export var speed := 100.0
@export var mouse_sensitivity := 0.002


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _unhandled_input(event):
	if event is InputEventMouseMotion:
		rotate_y(-event.relative.x * mouse_sensitivity)

		$Camera3D.rotate_x(-event.relative.y * mouse_sensitivity)
		$Camera3D.rotation.x = clamp(
			$Camera3D.rotation.x,
			deg_to_rad(-80),
			deg_to_rad(80)
		)


func _physics_process(delta):
	if not is_on_floor():
		velocity.y -= 9.8 * delta

	var input = Input.get_vector(
		"ui_left",
		"ui_right",
		"ui_up",
		"ui_down"
	)

	var direction = (
		transform.basis * Vector3(input.x, 0, input.y)
	).normalized()

	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)

	move_and_slide()


func _process(_delta):
	if Input.is_key_pressed(KEY_E):
		print("E PRESSED")

		if $Camera3D/InteractionRay.is_colliding():
			print("RAY HIT SOMETHING")

			var object = $Camera3D/InteractionRay.get_collider()
			print("HIT: ", object.name)

			if object.has_method("interact"):
				print("INTERACT FOUND")
				object.interact()
			else:
				print("NO INTERACT FUNCTION")
		else:
			print("RAY HIT NOTHING")
			
			
			
