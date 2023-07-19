extends Node3D

@export var visuals: Array[MeshInstance3D]

@onready var parent := get_node("../../BaseCounter") 


func _ready() -> void:
	Game.player.selected_counter_changed.connect(_on_selected_counter_change)


func _on_selected_counter_change(counter: ClearCounter) -> void:
	for visual in visuals:
		visual.visible = counter == parent
