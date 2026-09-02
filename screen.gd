extends StaticBody3D

@onready var panel = $SubViewport/ComputerUI/ComputerPanel

func interact():
	panel.visible = true
