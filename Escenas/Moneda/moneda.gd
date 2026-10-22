extends Node2D

@export var area_2d: Area2D

var contenedor_monedas: ContenedorMonedas

func _ready() -> void:
	if area_2d != null:
		area_2d.body_entered.connect(_recogida)
	else:
		push_error("ERROR: No se asignó el Area2D de la moneda")

	_iniciar_animacion()


func _recogida(body: Node2D) -> void:
	if body.is_in_group("personajes"):
		print("¡El personaje recogió una moneda!")

		if contenedor_monedas != null:
			contenedor_monedas.moneda_recogida()
			queue_free()
		else:
			print("ERROR: La moneda no tiene contenedor asignado")


func _iniciar_animacion() -> void:
	var tween: Tween = create_tween()
	tween.set_loops()

	tween.tween_property(
		self,
		"position:y",
		position.y - 5,
		0.5
	).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT)

	tween.tween_property(
		self,
		"position:y",
		position.y + 5,
		0.5
	).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT)
