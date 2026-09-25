extends TileMapLayer

var sombra = Vector2i(4, 2)
var ventana = get_viewport_rect().size
func _ready():
	clear()

func _process(_delta) :
	var resaltar:= local_to_map(get_local_mouse_position())
	sombreado(resaltar)

func sombreado(resaltar):
	clear()
	if get_parent().get_parent().celdas.has(resaltar):
		set_cell(resaltar,0,sombra,0)
		amplio(resaltar)
func amplio(resaltar):
	var numero =[]
	if get_parent().get_parent().get_parent().inicio == false and get_parent().reveladas.has(resaltar):
		for x in range(get_parent().get_parent().get_parent().columnas):
			for y in range(get_parent().get_parent().get_parent().filas):
				var celda = Vector2i(x,y)
				if abs(resaltar.x-x)<=1 and abs(resaltar.y-y)<=1:
					set_cell(celda,0,sombra,0)
					erase_cell(resaltar)
