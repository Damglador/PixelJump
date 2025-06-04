extends Control

func _ready() -> void:
	get_tree().paused = false # Вимикає паузу, якщо була

func _on_play_pressed() -> void: # Активується коли натискається кнопка "Грати"
	get_tree().change_scene_to_file("res://scenes/game.tscn") # Перемикає сцену на сцену гри

func _on_quit_pressed() -> void: # Активується коли натискається кнопка "Вийти"
	get_tree().quit(0) # Виходить з програми надсилаючи код 0, що означає успішний вихід програми
	
func _on_settings_pressed() -> void: # Активується коли натискається кнопка "Налаштування"
	$Settings.visible = true
