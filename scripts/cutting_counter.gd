extends BaseCounter
class_name CuttingCounter

signal progress_update(normalized_progress: float)
signal cutting_state_change(is_cutting: bool)

@export var kitchen_object_parent: KitchenObjectParent
@export var cutting_recipe_resources: Array[CuttingRecipeResource]

var _cutting_progress: float


func interact(player: Player) -> void:
	if not kitchen_object_parent.has_kitchen_object():
		var object_parent = player.kitchen_object_parent
		if object_parent.has_kitchen_object() and _has_recipe_for_input(object_parent.get_kitchen_object().get_resource()):
			player.kitchen_object_parent.get_kitchen_object().set_object_parent(kitchen_object_parent)
			progress_update.emit(0)
			_cutting_progress = 0
			
	elif not player.kitchen_object_parent.has_kitchen_object():
		kitchen_object_parent.get_kitchen_object().set_object_parent(player.kitchen_object_parent)


func interact_alternate(player: Player) -> void:
	if kitchen_object_parent.has_kitchen_object() and _has_recipe_for_input(kitchen_object_parent.get_kitchen_object().get_resource()):
		var current_object := kitchen_object_parent.get_kitchen_object()
		var cutting_recipe = _get_cutting_recipe_for_input(current_object.get_resource())
		
		if is_zero_approx(_cutting_progress):
			cutting_state_change.emit(true)
		
		_cutting_progress += 1
		progress_update.emit(_cutting_progress / cutting_recipe.max_cutting_progress)
		
		if cutting_recipe and _cutting_progress >= cutting_recipe.max_cutting_progress:
			var output := _recipe_output_for_input(current_object.get_resource())
			
			if output:
				current_object.destroy_self()
				KitchenObject.spawn(output, kitchen_object_parent)
			
			cutting_state_change.emit(false)


func _get_cutting_recipe_for_input(input: KitchenObjectResource) -> CuttingRecipeResource:
	for res in cutting_recipe_resources:
		if res.input == input:
			return res
	
	return null


func _has_recipe_for_input(input: KitchenObjectResource) -> bool:
	return _get_cutting_recipe_for_input(input) != null


func _recipe_output_for_input(input: KitchenObjectResource) -> KitchenObjectResource:
	var recipe = _get_cutting_recipe_for_input(input);
	
	if recipe:
		return recipe.output
	
	return null
