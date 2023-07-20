extends Camera3D


func _enter_tree() -> void:
	Game.camera = self
