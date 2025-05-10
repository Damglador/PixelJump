extends CharacterBody2D

@onready var walls = get_tree().get_root().get_node("Game/Walls")
@onready var death_zone = get_tree().get_root().get_node("Game/DeathZone")
@export var POWER = 1
@export var FRICTION = 3
var maxpos = 640

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#print("Char Y = " + str(position.x))
	#print("Char X = " + str(position.y))
	position.x = 170
	position.y = 580
	# =========== DEBUG =================
	#print(get_tree().get_root().get_tree_string())
	#print(get_tree().get_root().get_node("Game/Walls").get_tree_string())
	#print(get_tree().get_root().get_tree_string())
	pass # Replace with function body

func _launch(start:Vector2, end:Vector2) -> void:
	var y = (-(end[1] - start[1])*4) * POWER
	#print("Start = " + str(start[0]) + " " + str(start[1]))
	#print("End = " + str(end[0]) + " " + str(end[1]))
	var x = (-(end[0] - start[0])  ) * POWER
	#print("X = " + str(x))
	#print("Y = " + str(y))
	jump(x, y)


var startpos = null
var endpos = null

func _input(event: InputEvent) -> void:
	if event is InputEventScreenTouch: 
		if event.is_pressed():
			startpos = event.get_position()
		if event.is_released():
			endpos = event.get_position()
			_launch(startpos, endpos)
	#if event is InputEventScreenDrag:
		#position.x = event.get_position().x
		#position.y = event.get_position().y
		#print(event.get_position())
	
		
func jump(x, y) -> void:
	if is_on_floor():
		velocity.y += clamp(y, y, 1000)
		velocity.x += clamp(x, x, 500)

func _process(_delta: float) -> void:
	pass

func move_maxpos() -> void:
	if position.y < maxpos:
		maxpos = position.y
		death_zone.position.y = maxpos - 200
		#print(death_zone.position.y)
		#$Camera2D.position_smoothing_enabled = false
	#else:
		#$Camera2D.position_smoothing_enabled = true

func _physics_process(delta: float) -> void:
	walls.position.y = self.position.y # Move walls
	move_maxpos()
	var collision := move_and_collide(velocity * delta, true) # Detect collision
	if collision != null and collision.get_angle() > 0:
		velocity = velocity.bounce(collision.get_normal())
		velocity.x *= 0.5
		print(collision.get_angle())
		print(collision.get_collider())
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	else:
		velocity.x = move_toward(velocity.x, 0, FRICTION)

	move_and_slide()
	
