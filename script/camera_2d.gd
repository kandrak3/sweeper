extends Camera2D

func _ready():
	var tablero = Vector2(get_parent().filas*get_parent().size, get_parent().columnas*get_parent().size)
	self.position = Vector2(tablero.y/2,(tablero.x/2))
	
