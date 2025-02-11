extends RayCast3D

@export var wheel_radius : float = 0.5
@export var min_spring_length : float = 0.3
@export var max_spring_length : float = 1.0
@export var spring_rest_length : float = 0.8

const SPRING_STRENGTH : float = 10.0
const SUSPENSION_SPRING_DAMPER : float = 5.0

@onready var vehicle : RigidBody3D = get_parent()

var prev_spring_length : float = 0.0
var prev_offset : float = 0.0

func _ready() -> void:
	# Set RayCast length to maximum distance the tire can touch the ground
	set_target_position(Vector3(0.0, -(max_spring_length + wheel_radius), 0.0))

func _physics_process(delta: float) -> void:
	if is_colliding():
		pass
	#	var raycast_origin : Vector3 = global_position
	#	var raycast_destination : Vector3 = get_collision_point()
	#	var distance_to_hit : float = raycast_destination.distance_to(raycast_origin)
	#	
	#	var spring_offset : float = REST_DISTANCE - distance_to_hit - wheel_radius
	#	print(spring_offset)
		#DebugDraw3D.draw_arrow(global_position, to_global(position + Vector3(-position.x, (suspension_force.y / 4), -position.z)), Color.GREEN, 0.01, true)
