extends StaticBody2D

@onready var player = get_tree().get_root().get_node("Game/Player")
@onready var camera = player.get_node("CharacterBody2D/Camera2D")


func _on_area_2d_body_entered(body: Node2D) -> void: # Активується коли щось входить у область
	if is_instance_valid(body):
			if body.is_in_group("Platform"):# Якщо це платформа
				body.queue_free()           # Видаляє її
			if body.is_in_group("Player"):  # Якщо це гравець
				camera.position_smoothing_enabled = true # Вимикає рух камери. Оскільки у камери швидкість згладжування дорівнює нулю, увімкнення згладжування вимикає її рух
				await get_tree().create_timer(0.5).timeout # Чекає 0,5 секунд
				get_tree().reload_current_scene() # Перезапускає сцену
