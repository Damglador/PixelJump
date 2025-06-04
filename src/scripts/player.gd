extends CharacterBody2D

@onready var walls = get_tree().get_root().get_node("Game/Walls")
@onready var death_zone = get_tree().get_root().get_node("Game/DeathZone")
@onready var score_display = get_tree().get_root().get_node("Game/Player/CanvasLayer/MarginContainer/Label")
@onready var second = get_tree().get_root().get_node("Game/Player/Second")
@export_category("Jump")
@export var MAXJUMP_Y = 1000
@export var MAXJUMP_X = 500
@export var FRICTION = 3
@export var XOFFSET = 1
var jump_buffer = Vector2.ZERO
var score = 4
var maxpos = 640
var startpos = null
var endpos = null
var arrow_end = Vector2.ZERO

func _ready() -> void:
	position.x = 170
	position.y = 580
	# =========== DEBUG =================
	#print(get_tree().get_root().get_tree_string())
	#print(get_tree().get_root().get_node("Game/Walls").get_tree_string())
	#print(get_tree().get_root().get_tree_string())
	pass # Replace with function body



func launch(start:Vector2, end:Vector2) -> void:
	var direction = Vector2.ZERO
	direction.y = ((start[1] - end[1])        ) * vardb.JUMP_POWER
	direction.x = ((start[0] - end[0])/XOFFSET) * vardb.JUMP_POWER
	if not is_on_floor():
		jump_buffer = direction
	else:
		jump(direction)
	
	arrow_end = Vector2.ZERO
	queue_redraw()



func _input(event: InputEvent) -> void:
	if event is InputEventScreenTouch:
		if event.is_pressed():
			startpos = event.get_position()
		if event.is_released() and startpos != null:
			endpos = event.get_position()
			launch(startpos, endpos)
	if event is InputEventScreenDrag and startpos != null:
		arrow_end = event.get_position() - startpos
		queue_redraw()



func jump(direction) -> void:
	velocity.y += clamp(direction.y, -MAXJUMP_Y, MAXJUMP_Y)
	velocity.x += clamp(direction.x, -MAXJUMP_X, MAXJUMP_X)
	jump_buffer = Vector2.ZERO



func _process(_delta: float) -> void:
	score_display.text = "Рахунок: " + str(roundi(score))



func _on_second_timeout():
	score -= 5
	second.start()



func move_maxpos() -> void:
	if position.y < maxpos:
		var maxposold = maxpos
		maxpos = position.y
		score += abs(abs(maxpos) - abs(maxposold))/10
		death_zone.position.y = maxpos - 200
		#print(death_zone.position.y)
		#$Camera2D.position_smoothing_enabled = false
	#else:
		#$Camera2D.position_smoothing_enabled = true



const head_length = 40.0
const head_angle = 0.3 #rad
var clr := Color.RED
func _draw() -> void:
	# Стрілка
	var end = -arrow_end
	var length = 0
	length = min(end.length(), 100.0)
	end = end.normalized() * length
	
	
	draw_line(Vector2.ZERO, end, clr)
	var head : Vector2 = -end.normalized() * head_length
	draw_line(end, end + head.rotated(head_angle),  clr)
	draw_line(end, end + head.rotated(-head_angle),  clr)



func _physics_process(delta: float) -> void:
	walls.position.y = self.position.y # Move walls
	move_maxpos()
	var collision := move_and_collide(velocity * delta, true) # Detect collision
	if collision != null and collision.get_angle() > 0:
		velocity = velocity.bounce(collision.get_normal())
		velocity.x *= 0.5
	if not is_on_floor():
		velocity.y += get_gravity().y * delta # Add the gravity.
	else:
		if jump_buffer:
			jump(jump_buffer)
		velocity.x = move_toward(velocity.x, 0, FRICTION)
	move_and_slide()
	
