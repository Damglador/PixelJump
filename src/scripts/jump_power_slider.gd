extends HSlider

func _ready() -> void:
	value = vardb.JUMP_POWER

func _on_value_changed(value: float) -> void:
	get_parent().get_node("Indicator").text = str(roundi(value))
	vardb.JUMP_POWER = value
