extends Control

const torque_curve : Curve = preload("res://experimental/torque_curve.tres")
const braking_curve : Curve = preload("res://experimental/engine_braking_curve.tres")


func _getTorqueAtPartThrottle(rpm : float, throttle : float) -> float:
	var min : float = braking_curve.sample_baked(rpm)
	var rpm_percent : float = rpm / (2200 - 400) #- 0.5 * rpm_percent
	return min + (torque_curve.sample_baked(rpm) - min) * throttle * (1 - 0.5 * pow(rpm_percent, 2))


func _ready() -> void:
	var torquePlot100 : PlotItem = $Graph2D.add_plot_item("Torque 100%", Color.GREEN, 2)
	var torquePlot75 : PlotItem = $Graph2D.add_plot_item("Torque 75%", Color.GREEN, 2)
	var torquePlot50 : PlotItem = $Graph2D.add_plot_item("Torque 50%", Color.GREEN, 2)
	var torquePlot25 : PlotItem = $Graph2D.add_plot_item("Torque 25%", Color.GREEN, 2)
	var torquePlotBraking : PlotItem = $Graph2D.add_plot_item("Torque 0%", Color.BLUE, 2)
	var powerPlot : PlotItem = $Graph2D.add_plot_item("Power", Color.RED, 2)
	
	var zeroLine : PlotItem = $Graph2D.add_plot_item("ZERO", Color.WHITE, 1)
	zeroLine.add_point(Vector2(400, 0))
	zeroLine.add_point(Vector2(2200, 0))
	
	for rpm in range(400, 2200, 50):
		var torque100 : float = torque_curve.sample_baked(rpm)
		torquePlot100.add_point(Vector2(rpm, torque100))
		torquePlot75.add_point(Vector2(rpm, _getTorqueAtPartThrottle(rpm, 0.75)))
		torquePlot50.add_point(Vector2(rpm, _getTorqueAtPartThrottle(rpm, 0.50)))
		torquePlot25.add_point(Vector2(rpm, _getTorqueAtPartThrottle(rpm, 0.25)))
		torquePlotBraking.add_point(Vector2(rpm, _getTorqueAtPartThrottle(rpm, 0)))
		powerPlot.add_point(Vector2(rpm, (torque100 * rpm) / 5252))
