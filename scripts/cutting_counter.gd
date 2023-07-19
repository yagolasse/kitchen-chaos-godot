extends BaseCounter
class_name CuttingCounter


@export var kitchen_object_parent: KitchenObjectParent
@export var cutting_recipe_resources: Array[CuttingRecipeResource]


func interact(player: Player) -> void:
	if not kitchen_object_parent.has_kitchen_object():
		var object_parent = player.kitchen_object_parent
		if object_parent.has_kitchen_object() and _has_recipe_for_input(object_parent.get_kitchen_object().get_resource()):
			player.kitchen_object_parent.get_kitchen_object().set_object_parent(kitchen_object_parent)
	elif not player.kitchen_object_parent.has_kitchen_object():
		kitchen_object_parent.get_kitchen_object().set_object_parent(player.kitchen_object_parent)


func interact_alternate(player: Player) -> void:
	if kitchen_object_parent.has_kitchen_object():
		var current_object := kitchen_object_parent.get_kitchen_object()
		var output := _recipe_output_for_input(current_object.get_resource())
		
		if output:
			current_object.destroy_self()
			KitchenObject.spawn(output, kitchen_object_parent)


func _has_recipe_for_input(kitchen_object_resource: KitchenObjectResource) -> bool:
	for res in cutting_recipe_resources:
		if res.input == kitchen_object_resource:
			return true
	
	return false


func _recipe_output_for_input(kitchen_object_resource: KitchenObjectResource) -> KitchenObjectResource:
	for res in cutting_recipe_resources:
		if res.input == kitchen_object_resource:
			return res.output
	
	return null
