extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_tree().paused = false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_pause_pressed() -> void:
	get_tree().paused = !get_tree().paused
	if get_tree().paused:
		$CenterContainer/VBoxContainer/Paused.visible = true
	else:
		$CenterContainer/VBoxContainer/Paused.visible = false
	#get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
	pass # Replace with function body.
@onready var lineend = Vector2.ZERO
@onready var linestart = null
var clr := Color.RED
func _input(event: InputEvent) -> void:
	if event is InputEventScreenTouch:
		if event.is_pressed():
			linestart = event.get_position()
		if event.is_released() and linestart != null:
			lineend = Vector2.ZERO
			linestart = Vector2.ZERO
			queue_redraw()
	if event is InputEventScreenDrag and linestart != null:
		lineend = event.get_position()
		queue_redraw()
		
func _draw() -> void:
	if linestart != null and lineend != null:
		draw_line(linestart, lineend, clr)
