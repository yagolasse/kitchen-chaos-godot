extends BaseCounter
class_name ClearCounter


@export var kitchen_object_parent: KitchenObjectParent
@export var kitchen_object_resource: KitchenObjectResource


func interact(player: Player) -> void:
	if not kitchen_object_parent.has_kitchen_object():
		if player.kitchen_object_parent.has_kitchen_object():
			player.kitchen_object_parent.get_kitchen_object().set_object_parent(kitchen_object_parent)
	elif not player.kitchen_object_parent.has_kitchen_object():
		kitchen_object_parent.get_kitchen_object().set_object_parent(player.kitchen_object_parent)
