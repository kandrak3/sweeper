extends Button
@onready var Facil :Button

func _ready() -> void:
	pass
	#Facil.pressed.connect(_principiante())
	
func _principiante():
	get_parent().get_parent().get_parent().dificultad= 0
