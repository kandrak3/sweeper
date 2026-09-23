extends Node2D

func _on_cubierta_explosion(pos) -> void:
	$explosion.process_material.emission_shape_offset = Vector3(pos.x*16+8,pos.y*16+8,0)
	$explosion.emitting = true
	await get_tree().create_timer(0.1).timeout
	$explosion.emitting = false
	#cadena()
func cadena():
	for i in range(get_parent().get_parent().minado.size()):
		var s = get_parent().get_parent().minado[i]
		$explosion.process_material.emission_shape_offset = Vector3(s.x*16+8,s.y*16+8,0)
		$explosion.emitting = true
		await get_tree().create_timer(0.1).timeout
		parar_explosion()
func parar_explosion():
	$explosion.emitting = false
