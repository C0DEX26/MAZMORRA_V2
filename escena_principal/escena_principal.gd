extends Node2D

@export var niveles: Array[PackedScene]

var _nivel_actual: int = 1
var _nivel_instanciado: Node


func _ready() -> void:
	_crear_nivel(_nivel_actual)


func _crear_nivel(num_nivel: int) -> void:
	print("Cargando nivel: ", num_nivel)

	if num_nivel < 1 or num_nivel > niveles.size():
		push_error("ERROR: El nivel no existe.")
		return

	_nivel_instanciado = niveles[num_nivel - 1].instantiate()
	add_child(_nivel_instanciado)

	var hijos := _nivel_instanciado.get_children()

	for hijo in hijos:
		if hijo.is_in_group("personajes"):
			hijo.personaje_muerto.connect(_reiniciar_nivel)
			break


func _eliminar_nivel() -> void:
	if is_instance_valid(_nivel_instanciado):
		_nivel_instanciado.queue_free()
		_nivel_instanciado = null


func _reiniciar_nivel() -> void:
	print("Reiniciando nivel: ", _nivel_actual)

	_eliminar_nivel()
	_crear_nivel.call_deferred(_nivel_actual)


func siguiente_nivel() -> void:
	if _nivel_actual < niveles.size():
		print("¡Nivel ", _nivel_actual, " completado!")

		_nivel_actual += 1

		_eliminar_nivel()
		_crear_nivel.call_deferred(_nivel_actual)

	else:
		print("¡Felicidades! Has completado todos los niveles.")
