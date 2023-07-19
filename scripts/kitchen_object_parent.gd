extends Node
class_name KitchenObjectParent

@export var position_reference: Node3D


var _kitchen_object: KitchenObject:
	get = get_kitchen_object, set = set_kitchen_object


func clear_kitchen_object() -> void:
	_kitchen_object = null


func has_kitchen_object() -> bool:
	return _kitchen_object != null


func get_kitchen_object_follow_node() -> Node3D:
	return position_reference


func set_kitchen_object(kitchen_object: KitchenObject) -> void:
	_kitchen_object = kitchen_object


func get_kitchen_object() -> KitchenObject:
	return _kitchen_object
