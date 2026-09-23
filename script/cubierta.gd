extends TileMapLayer
#diccionario
var cubierta = Vector2i(3, 2)
var bandera = Vector2i(4, 1)
var errorban = Vector2i(0, 2)
var sombra = Vector2i(4, 2)
var minaderrota = Vector2i(2, 2)
var vacia = Vector2i(0, 0)
var ventana = get_viewport_rect().size
var banderas :=[]
var reveladas :=[]
var destapar:=[]
signal derrota
signal victoria
signal arranque
signal banderamas
signal banderamenos
signal explosion
func _ready():
	reiniciar()
	
func reiniciar():
	clear()
	destapar.clear()
	banderas.clear()
	cobertura()

func cobertura():
	for y in range(0, get_parent().get_parent().filas):
		for x in range(0, get_parent().get_parent().columnas):
			var tapado = Vector2i(x, y)
			get_parent().celdas.append(tapado)
			set_cell(tapado,0,cubierta,0)
 
func _input(event):
	if event is InputEventMouseButton:
		if event.position.x <= ventana.x/2 - get_parent().get_parent().tablero.x/2 and (event.position.x >= ventana.x/2 + get_parent().get_parent().tablero.x/2
		and event.position.y <= ventana.y/2 - get_parent().get_parent().tablero.y/2 and event.position.y >= ventana.y/2 + get_parent().get_parent().tablero.y/2):
			if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
				ClickIzquierdo(position)
			elif event.button_index == MOUSE_BUTTON_RIGHT and event.pressed:
				ClickDerecho(position)
			
func ClickIzquierdo(pos):
	if get_parent().get_parent().inicio == true:
		if get_parent().celdas.has(pos):
			while not get_parent().ceros.has(pos):
				get_parent().reiniciar()
			get_parent().get_parent().inicio = false
			mostrar(pos)
			arranque.emit()
		else:
			mostrar(pos)
	else:
		get_parent().get_parent().inicio = false
		mostrar(pos)

func mostrar(pos):
	var revelar:= [pos]
	while not revelar.is_empty():
		match get_cell_atlas_coords(revelar[0]):
			bandera:
				revelar.erase(revelar[0])
			cubierta:
				if get_parent().minado.has(revelar[0]):
					mostrarminas(pos)
					set_cell(revelar[0],0,minaderrota,0)
					derrota.emit()
					revelar.erase(revelar[0])
				elif get_parent().ceros.has(pos):
					$cero.play()
					erase_cell(revelar[0])
					destapar.append(revelar[0])
					limpiarlibre()
					revelar.erase(revelar[0])
					comprobar()
					if reveladas.size()==get_parent().vacias.size():
						ganar()
						victoria.emit()
					#condicionvictoria()
				else:
					erase_cell(revelar[0])
					revelar.erase(revelar[0])
					comprobar()
					if reveladas.size()==get_parent().vacias.size():
						ganar()
						victoria.emit()
					#condicionvictoria()
			_:
				revelar.erase(revelar[0])
func ClickDerecho(pos):
	if get_parent().get_parent().inicio == false:
		proteger(pos)
func proteger(pos):
	var marcar:= [pos]
	var colocadas:= banderas.size()
	while not marcar.is_empty():
		if get_cell_atlas_coords(marcar[0]) == cubierta:
			if colocadas < get_parent().get_parent().cantidad:
				set_cell(marcar[0],0,bandera,0)
				banderas.append(marcar[0])
				marcar.erase(marcar[0])
				banderamas.emit()
			else:
				marcar.erase(marcar[0])
		elif get_cell_atlas_coords(marcar[0]) == bandera:
			set_cell(marcar[0],0,cubierta,0)
			banderas.erase(marcar[0])
			marcar.erase(marcar[0])
			banderamenos.emit()
		else:
			banderas.erase(marcar[0])
			marcar.erase(marcar[0])
func mostrarminas(pos):
	$caugth.play()
	explosion.emit(pos)
	await get_tree().create_timer(0.5).timeout
	for i in range(get_parent().minado.size()):
		if get_parent().minado[i] != pos:
			$explode.play()
			erase_cell(get_parent().minado[i])
	for j in range(banderas.size()):
		if get_parent().vacias.has(banderas[j]):
			set_cell(banderas[j],0,errorban,0)
func limpiarlibre():
	for i in range(destapar.size()):
		if get_cell_atlas_coords(destapar[i]) == Vector2i(-1,-1):
			contorno(destapar[i])
#			condicionvictoria()
func contorno(centro):
	for x in range(get_parent().get_parent().columnas):
		for y in range(get_parent().get_parent().filas):
			var celda = Vector2i(x,y)
			if abs(centro.x-x)<=1 and abs(centro.y-y)<=1:
				erase_cell(celda)
				if get_parent().ceros.has(celda) and not destapar.has(celda):
					destapar.append(celda)
					limpiarlibre()
func comprobar():
	reveladas.clear()
	for x in range(get_parent().get_parent().columnas):
		for y in range(get_parent().get_parent().filas):
			var celda = Vector2i(x,y)
			if get_cell_atlas_coords(celda) == Vector2i(-1,-1):
				reveladas.append(celda)
	print(get_parent().vacias.size(), "=" , reveladas.size())
#func condicionvictoria():
#	if reveladas.size()==get_parent().vacias.size():
#		ganar()
#		victoria.emit()
func ganar():
	for i in range(get_parent().minado.size()):
		set_cell(get_parent().minado[i],0,bandera,0)
func _process(_delta):
	var cursor :=local_to_map(get_local_mouse_position())
	if Input.is_action_just_pressed("RatonIzq"):
		ClickIzquierdo(cursor)
	elif Input.is_action_just_pressed("RatonDer"):
		ClickDerecho(cursor)
