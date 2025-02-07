extends RigidBody3D

const SUSPENSION_REST_DISTANCE : float = 0.35
const SUSPENSION_SPRING_STRENGTH : float = 10.0
const SUSPENSION_SPRING_DAMPER : float = 2.0


func _physics_process(delta: float) -> void:
	pass
	#steering = move_toward(steering, Input.get_axis("Right", "Left"), delta * 2)
