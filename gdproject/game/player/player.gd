extends CharacterBody3D

const SPEED: float = 4.0
const JUMP_VELOCITY: float = 5.0
const CAMERA_SENSIVITY: float = 0.005

@onready var camera: Camera3D = $Camera3D
var look_dir: Vector2
var isPaused: bool = false


func _init() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _process(delta: float) -> void:
	if not isPaused:
		rotate_y(-look_dir.x * CAMERA_SENSIVITY)
		camera.rotate_x(-look_dir.y * CAMERA_SENSIVITY)
		camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-90), deg_to_rad(90))
		look_dir = Vector2.ZERO


func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("Pause"):
		isPaused = !isPaused
		
		if (isPaused):
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		else:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
	if not isPaused:
		if not is_on_floor():
			velocity += get_gravity() * delta

		if is_on_floor():
			var playerSpeed := (1.5 * SPEED) if Input.is_action_pressed("Sprint") else SPEED
			var input_dir := Input.get_vector("Left", "Right", "Forward", "Back")
			var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
			#if direction:
			velocity.x = direction.x * playerSpeed
			velocity.z = direction.z * playerSpeed
			#else:
			#	velocity.x = move_toward(velocity.x, 0, playerSpeed)
			#	velocity.z = move_toward(velocity.z, 0, playerSpeed)
				
			if Input.is_action_just_pressed("Jump"):
				velocity.y = JUMP_VELOCITY

		move_and_slide()


func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion: look_dir = event.relative
