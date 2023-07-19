extends CharacterBody3D
class_name Player

signal selected_counter_changed(counter: ClearCounter)

@export var speed: float
@export var interaction_range: float
@export_flags_3d_physics var counter_collision_mask: int

var _last_selected_counter: ClearCounter
var _last_movement_direction := Vector3.ZERO


func _enter_tree() -> void:
	Game.player = self


func _ready() -> void:
	GameInput.interact_pressed.connect(_on_interact_pressed)


func _physics_process(delta: float) -> void:
	_handle_interactions()
	_handle_movement()


func _handle_interactions() -> void:
	var space_state = get_world_3d().direct_space_state
	var params = PhysicsRayQueryParameters3D.create(position, position + _last_movement_direction * interaction_range, counter_collision_mask, [self])
	var result = space_state.intersect_ray(params)
	
	_last_selected_counter = result.collider if result else null
	selected_counter_changed.emit(_last_selected_counter)


func _handle_movement() -> void:
	var input_dir := GameInput.get_input_vector_normalized()
	var move_direction := Vector3(input_dir.x, 0, input_dir.y)
	velocity = move_direction * speed
	
	if move_direction != Vector3.ZERO:
		_last_movement_direction = move_direction
		look_at(position - move_direction)
	
	move_and_slide()


func _on_interact_pressed() -> void:
	if _last_selected_counter:
		_last_selected_counter.interact()


func is_walking() -> bool:
	return velocity != Vector3.ZERO
