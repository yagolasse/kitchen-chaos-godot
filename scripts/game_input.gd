extends Node

signal interact_pressed()
signal interact_alternate_pressed()


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		interact_pressed.emit()
	if event.is_action_pressed("ui_end"):
		interact_alternate_pressed.emit()


func get_input_vector_normalized() -> Vector2:
	return Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down").normalized()
