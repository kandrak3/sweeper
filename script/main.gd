extends Node2D

#tablero
var columnas : int 
var filas : int 
var cantidad : int 
const size : int = 16
var ancho : int = columnas*size
var alto : int = filas*size
var tablero = Vector2(ancho, alto)
var tiempo: int
var restantes:int
var inicio:bool
var pausado = false
signal confeti

#mapa
var minado := []
var vacias:=[]

func _ready():
	$interfaz/Estado.text = "Selecciona una dificultad."
	$interfaz/custom/FILAS.min_value = 4
	$interfaz/custom/FILAS.max_value = 40
	$interfaz/custom/COLUMNAS.min_value = 4
	$interfaz/custom/COLUMNAS.max_value = 60
	$interfaz/custom/MINAS.min_value = 1
	$interfaz/custom/MINAS.max_value = int(columnas*filas*0.25)
	$interfaz/custom/FILAS.visible = false
	$interfaz/custom/COLUMNAS.visible = false
	$interfaz/custom/MINAS.visible = false
	$interfaz/custom/listo.visible = false
	$Node/pausado/pausa/Label.text = "Bienvenido :)"
	$Node/pausado/pausa/REINICIAR.disabled = true
	$Node/pausado/pausa/REANUDAR.text = "JUGAR"
	$interfaz/dificultad/PERSONALIZADO.disabled = false
	$interfaz/dificultad/facil.disabled = false
	$interfaz/dificultad/dificil.disabled = false
	$interfaz/dificultad/medio.disabled = false
	inicio = false
func principiante():
	columnas = 8
	filas = 8
	cantidad = 10
	$interfaz/custom/FILAS.set_value_no_signal(8)
	$interfaz/custom/COLUMNAS.set_value_no_signal(8)
	$interfaz/custom/MINAS.min_value = 1
	$interfaz/custom/MINAS.max_value = int(columnas*filas*0.25)
	$interfaz/custom/MINAS.set_value_no_signal(10)
	$interfaz/custom/FILAS.visible = false
	$interfaz/custom/COLUMNAS.visible = false
	$interfaz/custom/MINAS.visible = false
	$interfaz/custom/listo.visible = false
	$interfaz/dificultad/PERSONALIZADO.disabled = false
	$interfaz/dificultad/facil.disabled = true
	$interfaz/dificultad/dificil.disabled = false
	$interfaz/dificultad/medio.disabled = false
	$campo/cubierta/confeti/confeti.emitting = false
	$campo/cubierta/explosion/explosion.emitting = false
	reiniciar()
	
func intermedio():
	columnas = 16
	filas = 16
	cantidad = 40
	$interfaz/custom/FILAS.set_value_no_signal(16)
	$interfaz/custom/COLUMNAS.set_value_no_signal(16)
	$interfaz/custom/MINAS.min_value = 1
	$interfaz/custom/MINAS.max_value = int(columnas*filas*0.25)
	$interfaz/custom/MINAS.set_value_no_signal(40)
	$interfaz/custom/FILAS.visible = false
	$interfaz/custom/COLUMNAS.visible = false
	$interfaz/custom/MINAS.visible = false
	$interfaz/custom/listo.visible = false
	$interfaz/dificultad/PERSONALIZADO.disabled = false
	$interfaz/dificultad/facil.disabled = false
	$interfaz/dificultad/dificil.disabled = false
	$interfaz/dificultad/medio.disabled = true
	$campo/cubierta/confeti/confeti.emitting = false
	$campo/cubierta/explosion/explosion.emitting = false
	reiniciar()
	
func experto():
	columnas = 30
	filas = 16
	cantidad = 99
	$interfaz/custom/FILAS.set_value_no_signal(16)
	$interfaz/custom/COLUMNAS.set_value_no_signal(30)
	$interfaz/custom/MINAS.min_value = 1
	$interfaz/custom/MINAS.max_value = int(columnas*filas*0.25)
	$interfaz/custom/MINAS.set_value_no_signal(99)
	$interfaz/custom/FILAS.visible = false
	$interfaz/custom/COLUMNAS.visible = false
	$interfaz/custom/MINAS.visible = false
	$interfaz/custom/listo.visible = false
	$interfaz/dificultad/PERSONALIZADO.disabled = false
	$interfaz/dificultad/facil.disabled = false
	$interfaz/dificultad/dificil.disabled = true
	$interfaz/dificultad/medio.disabled = false
	$campo/cubierta/confeti/confeti.emitting = false
	$campo/cubierta/explosion/explosion.emitting = false
	reiniciar()
	
func personalizado():
	$interfaz/custom/FILAS.visible = true
	$interfaz/custom/COLUMNAS.visible = true
	$interfaz/custom/MINAS.visible = true
	$interfaz/custom/listo.visible = true
	$interfaz/custom/MINAS.min_value = 1
	$interfaz/custom/MINAS.max_value = int(columnas*filas*0.25)
	$"interfaz/custom/MOSTRAR FILAS".text = "FILAS: " + str(filas)
	$"interfaz/custom/MOSTRAR COLUMNAS".text = "COLUMNAS: " + str(columnas)
	$interfaz/Label.text = "RESTANTES: " + str(restantes) 
	$"interfaz/custom/MOSTRAR MINAS".text = "MINAS: " + str(cantidad)
	$interfaz/dificultad/PERSONALIZADO.disabled = true
	$interfaz/dificultad/facil.disabled = false
	$interfaz/dificultad/dificil.disabled = false
	$interfaz/dificultad/medio.disabled = false
	$campo/cubierta/explosion/explosion.emitting = false
	$campo/cubierta/confeti/confeti.emitting = false

func custom():
	$interfaz/Estado.text = "Click sobre el tablero para iniciar."
	reiniciar()

func reiniciar():
	inicio = true
	$Timer.stop()
	tiempo = 0
	restantes = cantidad
	$interfaz/Label.text = "RESTANTES: " + str(restantes) + ", TIEMPO: " + str(tiempo)
	$interfaz/Estado.text = "Click sobre el tablero para iniciar."
	$"interfaz/custom/MOSTRAR FILAS".text = "FILAS: " + str(filas)
	$"interfaz/custom/MOSTRAR COLUMNAS".text = "COLUMNAS: " + str(columnas)
	$"interfaz/custom/MOSTRAR MINAS".text = "MINAS: " + str(cantidad)
	$campo.reiniciar()
	$Camera2D._ready()
	$campo/cubierta._ready()
	$campo/cubierta/confeti.parar_confeti()
	$campo/cubierta/explosion.parar_explosion()
	
	
func derrota():
	$interfaz/Estado.text = "Has perdido :("
	$Timer.stop()
	$Node/pausado/pausa/REANUDAR.text = 'MOSTRAR'
	$Node/pausado/pausa/REINICIAR.disabled = false
	$interfaz/dificultad/PERSONALIZADO.disabled = false
	$interfaz/dificultad/facil.disabled = false
	$interfaz/dificultad/dificil.disabled = false
	$interfaz/dificultad/medio.disabled = false
	await get_tree().create_timer(2).timeout
	$Node/pausado/pausa/Label.text = "Has perdido :("
	$Node/pausado.visible = true
func victoria():
	$interfaz/Estado.text = "Has ganado :)"
	$Timer.stop()
	$Node/pausado/pausa/REANUDAR.text = 'MOSTRAR'
	$Node/pausado/pausa/REINICIAR.disabled = false
	$interfaz/dificultad/PERSONALIZADO.disabled = false
	$interfaz/dificultad/facil.disabled = false
	$interfaz/dificultad/dificil.disabled = false
	$interfaz/dificultad/medio.disabled = false
	$victoria.play()
	confeti.emit()
	await get_tree().create_timer(2).timeout
	$Node/pausado/pausa/Label.text = "Has ganado :)"
	$Node/pausado.visible = true
func _on_filas_value_changed(value: float) -> void:
	filas = int($interfaz/custom/FILAS.value)
	$"interfaz/custom/MOSTRAR FILAS".text = "FILAS: " + str(filas)
	$interfaz/custom/MINAS.min_value = 1
	$interfaz/custom/MINAS.max_value = int(columnas*filas*0.25)
	$interfaz/dificultad/PERSONALIZADO.disabled = true
	$interfaz/custom/listo.disabled = false
	personalizado()
func _on_columnas_value_changed(value: float) -> void:
	columnas = int($interfaz/custom/COLUMNAS.value)
	$"interfaz/custom/MOSTRAR COLUMNAS".text = "COLUMNAS: " + str(columnas)
	$interfaz/custom/MINAS.min_value = 1
	$interfaz/custom/MINAS.max_value = int(columnas*filas*0.25)
	$interfaz/dificultad/PERSONALIZADO.disabled = true
	$interfaz/custom/listo.disabled = false
	personalizado()
func _on_minas_value_changed(value: float) -> void:
	cantidad = int($interfaz/custom/MINAS.value)
	restantes = cantidad
	$interfaz/Label.text = "RESTANTES: " + str(restantes) + str(tiempo)
	$"interfaz/custom/MOSTRAR MINAS".text = "MINAS: " + str(cantidad)
	$interfaz/dificultad/PERSONALIZADO.disabled = true
	$interfaz/custom/listo.disabled = false
	personalizado()

func _on_timer_timeout() -> void:
	tiempo += 1
	formato(tiempo)
	$interfaz/Label.text = "RESTANTES: " + str(restantes) + ", TIEMPO: " + formato(tiempo)
	
func formato(segundos: int) -> String:
	@warning_ignore("integer_division")
	var minutos : int = floor(segundos/60)
	var srestantes : int = segundos % 60
	return "%02d:%02d" % [minutos, srestantes]
	

func _on_cubierta_banderamas() -> void:
	restantes -=1
	$interfaz/Label.text = "RESTANTES: " + str(restantes) + ", TIEMPO: " + formato(tiempo)
	$"bandera+".play()

func _on_cubierta_banderamenos() -> void:
	restantes +=1
	$interfaz/Label.text = "RESTANTES: " + str(restantes) + ", TIEMPO: " + formato(tiempo)
	$"bandera-".play()

func _on_salir_pressed() -> void:
	get_tree().quit()

func _on_reiniciar_pressed() -> void:
	reiniciar() 
	$Node/pausado.visible = false
func _on_reanudar_pressed() -> void:
	get_tree().paused = false
	$Node/pausado.visible = false
