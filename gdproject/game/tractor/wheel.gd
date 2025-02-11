extends RayCast3D

@export var wheel_radius : float = 0.25
@export var max_spring_length : float = 0.5
@export var spring_strength : float = 2500.0
@export var damper_strength : float = 1800.0

@onready var vehicle_body : RigidBody3D = get_parent()
@onready var wheel_mesh : MeshInstance3D = $MeshInstance3D
@onready var gravity : float = ProjectSettings.get_setting("physics/3d/default_gravity")

var engine_torque : float = 100

var prev_offset : float = 0.0

func _ready() -> void:
	# Set RayCast length to maximum distance the tire can touch the ground
	set_target_position(Vector3(0.0, -(max_spring_length + wheel_radius), 0.0))
	wheel_mesh.position.y = -max_spring_length

func _physics_process(delta: float) -> void:
	if is_colliding():
		var raycast_origin : Vector3 = global_position
		var raycast_destination : Vector3 = get_collision_point()
		var distance_to_hit : float = raycast_destination.distance_to(raycast_origin)
		
		var spring_offset : float = (max_spring_length + wheel_radius) - distance_to_hit
		
		wheel_mesh.position.y = -max_spring_length + spring_offset
		
		var spring_velocity : float = (prev_offset - spring_offset) / delta
		prev_offset = spring_offset
		
		var suspension_force : float = spring_offset * spring_strength * gravity - spring_velocity * damper_strength
		
		vehicle_body.apply_force(basis.y * suspension_force, position)
		DebugDraw3D.draw_arrow(global_position, to_global(position + Vector3(-position.x, suspension_force / 1000.0, -position.z)), Color.GREEN, 0.1, true)
