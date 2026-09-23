extends Node2D

func _on_main_confeti() :
	var material = $confeti.process_material
	#GPUParticles2D.amount_ratio = get_parent().get_parent().get_parent().columnas*get_parent().get_parent().get_parent().filas
	material.emission_shape = ParticleProcessMaterial.EMISSION_SHAPE_BOX
	material.emission_box_extents = Vector3(get_parent().get_parent().get_parent().columnas*8,get_parent().get_parent().get_parent().filas*8,0)
	material.emission_shape_offset = Vector3(get_parent().get_parent().get_parent().columnas*8,get_parent().get_parent().get_parent().filas*8,0)
	$confeti.emitting = true
func parar_confeti():
	$confeti.emitting = false
