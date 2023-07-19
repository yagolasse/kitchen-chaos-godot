extends Node3D
class_name KitchenObject

@export var resource: KitchenObjectResource:
	get = get_resource

var _object_parent: KitchenObjectParent:
	get = get_object_parent, set = set_object_parent


static func spawn(kitchen_object_resource: KitchenObjectResource, kitchen_object_parent: KitchenObjectParent) -> KitchenObject:
		var packed_object: PackedScene = load(kitchen_object_resource.packed_scene_path)
		var object := packed_object.instantiate() as KitchenObject
		object.set_object_parent(kitchen_object_parent)
		return object


func get_resource() -> KitchenObjectResource:
	return resource


func set_object_parent(object_parent: KitchenObjectParent) -> void:
	if _object_parent != null:
		_object_parent.clear_kitchen_object()
	
	_object_parent = object_parent
	_object_parent.set_kitchen_object(self)
	
	if get_parent():
		reparent(_object_parent.get_kitchen_object_follow_node())
	else:
		_object_parent.get_kitchen_object_follow_node().add_child(self)
		
	position = Vector3.ZERO


func get_object_parent() -> KitchenObjectParent:
	return _object_parent


func destroy_self() -> void:
	_object_parent.clear_kitchen_object()
	
	queue_free()
