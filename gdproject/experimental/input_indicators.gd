extends HBoxContainer

func _process(_delta: float) -> void:
	$ThrottleIdicator.value = Input.get_action_strength("Throttle")
	$BrakeIndicator.value = Input.get_action_strength("Brake")
	$ClutchIndicator.value = Input.get_action_strength("Clutch")
