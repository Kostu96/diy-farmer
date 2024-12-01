extends CharacterBody3D

const SPEED: float = 5.0
const JUMP_VELOCITY: float = 3.5
const CAMERA_SENSIVITY: float = 3.5

var look_dir: Vector2
@onready var camera: Camera3D = $Camera3D

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Handle camera rotation.
	rotation.y -= look_dir.x * CAMERA_SENSIVITY * delta
	camera.rotation.x = clamp(camera.rotation.x - look_dir.y * CAMERA_SENSIVITY * delta, deg_to_rad(-90), deg_to_rad(90))
	look_dir = Vector2.ZERO

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("Left", "Right", "Forward", "Back")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion: look_dir = event.relative * 0.1
