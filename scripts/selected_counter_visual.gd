extends Node3D

@export var parent: BaseCounter
@export var visuals: Array[Node3D]


func _ready() -> void:
	Game.player.selected_counter_changed.connect(_on_selected_counter_change)


func _on_selected_counter_change(counter: BaseCounter) -> void:
	for visual in visuals:
		visual.visible = counter == parent
