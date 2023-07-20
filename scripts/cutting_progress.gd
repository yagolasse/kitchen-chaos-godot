extends Sprite3D
class_name CuttingProgress

const PERCENTAGE_COMPLETE := "param/percentage_complete"

@export var interpolation_speed: int
@export var cutting_counter: CuttingCounter

var _start_progress := 0.0
var _end_progress := 0.0


func _ready() -> void:
	cutting_counter.progress_update.connect(_on_progress_update)
	cutting_counter.cutting_state_change.connect(_on_cutting_state_change)
	rotate_y(get_parent().rotation.y)


func _process(delta: float) -> void:
	if not is_equal_approx(_start_progress, _end_progress):
		_start_progress = lerpf(_start_progress, _end_progress, delta * interpolation_speed)
		material_override.set(PERCENTAGE_COMPLETE, _start_progress)


func _on_cutting_state_change(is_cutting: bool) -> void:
	visible = is_cutting


func _on_progress_update(normalized_progress: float) -> void:
	if normalized_progress == 0: 
		_start_progress = 0
	
	_end_progress = normalized_progress
