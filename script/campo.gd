extends TileMapLayer
#diccionario
var mina = Vector2i(1, 2)
var vacia = Vector2i(0, 0)
var cubierta = Vector2i(3, 2)
var c1 = Vector2i(1,0)
var c2 = Vector2i(2,0)
var c3 = Vector2i(3,0)
var c4 = Vector2i(4,0)
var c5 = Vector2i(0,1)
var c6 = Vector2i(1,1)
var c7 = Vector2i(2,1)
var c8 = Vector2i(3,1)
#mapa
var minado :Array[Vector2i]= []
var celdas:Array[Vector2i]=[]
var vacias:Array[Vector2i]=[]
var ceros :Array[Vector2i]=[]
#tema
var tema: int = 0
#llamado ingreso primera vez
func _ready():
	reiniciar()
func color(hue):
	modulate = hue
func reiniciar():
	clear()
	minado.clear()
	celdas.clear()
	vacias.clear()
	ceros.clear()
	dispersion()
	segura()
#minar mapa
func dispersion():
	for i in range(get_parent().cantidad):
		var celdaminada = Vector2i(randi_range(0, get_parent().columnas - 1), randi_range(0, get_parent().filas - 1))
		while minado.has(celdaminada):
			celdaminada = Vector2i(randi_range(0, get_parent().columnas - 1), randi_range(0, get_parent().filas - 1))
		minado.append(celdaminada)
		minado.sort()
		set_cell(celdaminada,0,mina,0)
func segura():
	for y in range(0, get_parent().filas):
		for x in range(0, get_parent().columnas):
			var tapado = Vector2i(x, y)
			celdas.append(tapado)
			if not tapado in minado:
				vacias.append(tapado)
				vacias.sort()
	for i in range(0, (get_parent().columnas * get_parent().filas)-(get_parent().cantidad)):
		var libre = vacias[i] 
		contorno(libre)
		nada(libre)
func contorno(libre):
	var alrededor:= []
	alrededor.clear()
	for j in range(-1,2):
		for k in range(-1,2):
			var cercanas= Vector2i(libre.x-j,libre.y-k)
			alrededor.append(cercanas)
	contar(libre,alrededor)
func contar(libre, alrededor):
	var minascercanas:=[]
	minascercanas.clear()
	for a in range(alrededor.size()):
		var control = alrededor[a]
		var contador  = minascercanas.size()
		if minado.has(control): 
			minascercanas.append(control)
			contador = minascercanas.size()
			numerar(libre,contador)
func numerar(libre,contador):
	if not minado.has(libre): match contador:
		1: 
			set_cell(libre,0,c1,0)
		2: 
			set_cell(libre,0,c2,0)
		3: 
			set_cell(libre,0,c3,0)
		4: 
			set_cell(libre,0,c4,0)
		5: 
			set_cell(libre,0,c5,0)
		6: 
			set_cell(libre,0,c6,0)
		7: 
			set_cell(libre,0,c7,0)
		8: 
			set_cell(libre,0,c8,0)
func nada(celda):
	if get_cell_source_id(celda) == -1:
		set_cell(celda,0,vacia,0)
		ceros.append(celda)
