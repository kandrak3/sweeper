extends Timer
signal perdiste
signal ganaste
func _on_cubierta_arranque() -> void:
	start()
	await get_tree().create_timer(1).timeout
func derrota() -> void:
	parar() 
	perdiste.emit()
func victoria() -> void:
	parar()
	ganaste.emit()
func parar():
	stop()
