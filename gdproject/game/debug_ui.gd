extends Control

var minDelta : float = 1000.0
var maxDelta : float = 0.0

func _process(delta: float) -> void:
	if delta < minDelta:
		minDelta = delta
	if delta > maxDelta:
		maxDelta = delta
		
	$DeltaLabel.text = str("min: ", int(minDelta * 10000) * 0.1, " cur: ", int(delta * 10000) * 0.1, " max: ", int(maxDelta * 10000) * 0.1)
	$FSPLabel.text = str("FPS: ", int(Engine.get_frames_per_second()))
