class_name ContenedorMonedas
extends Node

var _total_monedas: int = 0
var _monedas_recogidas: int = 0

func _ready() -> void:
	var monedas := get_children()
	_total_monedas = monedas.size()
	_monedas_recogidas = 0

	for moneda in monedas:
		moneda.contenedor_monedas = self

	_actualizar_contador()


func moneda_recogida() -> void:
	_monedas_recogidas += 1

	print("Monedas: ", _monedas_recogidas, "/", _total_monedas)

	_actualizar_contador()

	if _monedas_recogidas >= _total_monedas:
		get_parent().get_parent().siguiente_nivel()


func _actualizar_contador() -> void:
	var escena_principal = get_parent().get_parent()

	var contador = escena_principal.get_node_or_null(
		"Interfaz/ContadorMonedas"
	)

	if contador != null:
		contador.text = "Monedas: %d / %d" % [
			_monedas_recogidas,
			_total_monedas
		]
