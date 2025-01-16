extends Control

var torqueValues : Array = [Vector2(600, 69), Vector2(650, 71), Vector2(700, 73),
	Vector2(750, 74.5), Vector2(800, 76), Vector2(850, 78), Vector2(900, 79.5), Vector2(950, 81),
	Vector2(1000, 82), Vector2(1050, 83.5), Vector2(1100, 85), Vector2(1150, 87), Vector2(1200, 88),
	Vector2(1250, 88), Vector2(1300, 87.5), Vector2(1350, 87), Vector2(1400, 86.5),
	Vector2(1450, 86), Vector2(1500, 85.5), Vector2(1550, 83.5), Vector2(1600, 81.5),
	Vector2(1650, 80), Vector2(1700, 78), Vector2(1750, 76), Vector2(1800, 74), Vector2(1850, 72),
	Vector2(1900, 69.5), Vector2(1950, 68), Vector2(2000, 66)]

func _ready() -> void:
	var torquePlot : PlotItem = $Graph2D.add_plot_item("Torque", Color.GREEN, 1.0)
	var powerPlot : PlotItem = $Graph2D.add_plot_item("Power", Color.BLUE, 1.0)
	
	for p in torqueValues:
		torquePlot.add_point(p)
		powerPlot.add_point(Vector2(p.x, (p.y * p.x) / 5252))
