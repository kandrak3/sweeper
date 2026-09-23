extends Node
func _input(event):
	if event.is_action_pressed("Pausa"):
		get_tree().paused =!get_tree().paused
		pausa()
		
		
func pausa():
	if get_tree().paused == true:
		$pausado.visible = true
		$pausado/pausa/REANUDAR.text = "REANUDAR"
		$pausado/pausa/REINICIAR.disabled = false
		$pausado/pausa/Label.text = "Pausado"
	elif get_tree().paused == false:
		$pausado.visible = false
		$pausado/pausa/REANUDAR.text = "REANUDAR"
		$pausado/pausa/REINICIAR.disabled = false
		$pausado/pausa/Label.text = "Pausado"
