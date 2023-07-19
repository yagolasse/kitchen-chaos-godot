extends Node3D

const IDLE := "Idle"
const WALK := "Walk"

@export var player: Player

@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _process(delta: float) -> void:
	var anim = WALK if player.is_walking() else IDLE
	animation_player.play(anim)
