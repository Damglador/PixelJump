extends StaticBody2D

@onready var player = get_tree().get_root().get_node("Game/Player")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	if is_instance_valid(body):
			if body.is_in_group("Platform"):
				body.queue_free()
			if body.is_in_group("Player"):
				player.get_node("CharacterBody2D/Camera2D").position_smoothing_enabled = true
				await get_tree().create_timer(0.5).timeout
				get_tree().reload_current_scene()
				pass
