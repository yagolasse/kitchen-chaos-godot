extends BaseCounter
class_name ContainerCounter


@export var kitchen_object_resource: KitchenObjectResource


func interact(player: Player) -> void:
	if not player.kitchen_object_parent.has_kitchen_object():
		var packed_object: PackedScene = load(kitchen_object_resource.packed_scene_path)
		var object := packed_object.instantiate() as KitchenObject
		object.set_object_parent(player.kitchen_object_parent)
