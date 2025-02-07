extends RayCast3D

@export var wheel_radius : float = 0.5
const SUSPENSION_REST_DISTANCE : float = 0.5
const SUSPENSION_SPRING_STRENGTH : float = 30.0
const SUSPENSION_SPRING_DAMPER : float = 3.0

@onready var vehicle : RigidBody3D = get_parent()

var prev_spring_length : float = 0.0

func _physics_process(delta: float) -> void:
	if is_colliding():
		var raycast_collision_point = get_collision_point()
		var distance = raycast_collision_point.distance_to(global_position)
		var spring_length = clamp(distance - wheel_radius, 0, SUSPENSION_REST_DISTANCE)
		var spring_force = SUSPENSION_SPRING_STRENGTH * (SUSPENSION_REST_DISTANCE - spring_length)
		var spring_velocity = (prev_spring_length - spring_length) / delta
		var damper_force = SUSPENSION_SPRING_DAMPER * spring_velocity
		var suspension_force = basis.y * (damper_force + spring_force)
		prev_spring_length = spring_length
		var point = Vector3(raycast_collision_point.x, raycast_collision_point.y + wheel_radius, raycast_collision_point.z)
		vehicle.apply_force(global_basis.y * suspension_force, point - vehicle.global_position)
