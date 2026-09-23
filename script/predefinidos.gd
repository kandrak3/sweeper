extends VBoxContainer

@onready var facil = $facil
@onready var medio = $medio
@onready var dificil = $dificil

func _ready():
	facil.pressed.connect(principiante())
	medio.pressed.conect(intermedio())
	dificil.pressed.connect(experto())
	
func principiante():
	columnas = 8
	filas = 8
	cantidad = 10
	
func intermedio():
	columnas = 16
	filas = 16
	cantidad = 40
	
func experto():
	columnas = 30
	filas = 16
	cantidad = 99
