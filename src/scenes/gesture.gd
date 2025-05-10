extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


var startpos = null
var endpos = null
func _input(event: InputEvent):
	if not event is InputEventScreenTouch:
		return 
	if event.is_pressed():
		startpos = event.position
	if event.is_released():
		endpos = event.position
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
