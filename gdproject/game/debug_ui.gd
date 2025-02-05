extends Control

const INTERVAL : float = 0.5

var accumulator : float = 0.0
var frames : int = 0

func _process(delta: float) -> void:
	accumulator += delta
	frames += 1
	if (accumulator > INTERVAL):
		var avgDelta: float = int(accumulator * 10000 / frames) * 0.1
		frames = 0
		accumulator -= INTERVAL
		
		$DeltaLabel.text = str("delta: ", avgDelta, " ms")
		$FSPLabel.text = str("FPS: ", int(Engine.get_frames_per_second()))
