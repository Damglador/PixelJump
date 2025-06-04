extends Control


func _ready() -> void: # Активується коли вузол ініціалізується
	get_tree().paused = false # Вимикає паузу, на випадок якщо вона була увімкнена
	$MarginContainer/Pause.grab_focus() # Фокусує кнопку паузи, для можливості пересування контролером чи стрілочками по меню
	
	

func _on_pause_pressed() -> void: # Активується коли натискається кнопка паузи
	get_tree().paused = !get_tree().paused # Призупиняє або продовжує гру
	if get_tree().paused: # Показує та ховає меню паузи
		$CenterContainer/VBoxContainer.visible = true
	else:
		$CenterContainer/VBoxContainer.visible = false
	# Забирає фокус, оскільки при закритті меню паузи фокус з кнопки може спасти і тоді це ламає навігацію по меню контролером чи стрілками
	$MarginContainer/Pause.grab_focus()

@onready var lineend = Vector2.ZERO
@onready var linestart = null
var clr := Color.RED
# Малює лінію від початкової точки натискання на екран до позиції вказівника
func _input(event: InputEvent) -> void:
	if event is InputEventScreenTouch:
		if event.is_pressed(): # Визначає початкову точку
			linestart = event.get_position() # Зберігає її
		# linestart != null для запобігання крашу у випадку перезапуску сцени. Активується коли гравець перестає тягнути
		if event.is_released() and linestart != null:
			# Стирає лінію
			lineend = Vector2.ZERO
			linestart = Vector2.ZERO
			queue_redraw()
	# Визначає позицію вказівника та малює до нього лінію від початкової позиції
	if event is InputEventScreenDrag and linestart != null:
		lineend = event.get_position()
		queue_redraw()

# Функці для малювання лінії
func _draw() -> void:
	if linestart != null and lineend != null: # Запобігання крашу у випадку відсутності змінних
		draw_line(linestart, lineend, clr)


func _on_to_menu_pressed() -> void: # Активується при натисканні "Головне меню" у меню паузи
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn") # Змінює сцену на головне меню


func _on_restart_pressed() -> void: # Активується при натисканні "Перезапустити" у меню паузи
	get_tree().reload_current_scene() # Перезапускає сцену


func _on_settings_pressed() -> void:
	$Settings.visible = true
