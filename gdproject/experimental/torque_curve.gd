extends Control

var torqueValues : Array = [Vector2(1100, 80), Vector2(1200, 88), Vector2(1300, 82)]

func _ready() -> void:
	var torquePlot : PlotItem = $Graph2D.add_plot_item("Torque", Color.GREEN, 1.0)
	var powerPlot : PlotItem = $Graph2D.add_plot_item("Power", Color.BLUE, 1.0)
	
	for p in torqueValues:
		torquePlot.add_point(p)
		powerPlot.add_point(Vector2(p.x, (p.y * p.x) / 5252))
