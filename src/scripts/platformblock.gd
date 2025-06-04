extends Node2D
var used = false

func _on_halfway_area_entered(_area: Area2D) -> void:
	if !used:
		var nextblock = self.duplicate()
		nextblock.position.y = position.y - 1300
		add_sibling(nextblock)
		self.used = true
