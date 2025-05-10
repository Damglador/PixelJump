extends CharacterBody2D

@onready var walls = get_tree().get_root().get_node("Game/Walls")
const SPEED = 300.0
const JUMP_VELOCITY = -400.0
@onready var death_zone = get_tree().get_root().get_node("Game/DeathZone")
@export var POWER = 1
var maxpos = 640

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Char Y = " + str(position.x))
	print("Char X = " + str(position.y))
	position.x = 170
	position.y = 580
	# =========== DEBUG =================
	#print(get_tree().get_root().get_tree_string())
	#print(get_tree().get_root().get_node("Game/Walls").get_tree_string())
	pass # Replace with function body

func _launch(start:Vector2, end:Vector2) -> void:
	print("Start = " + str(start[0]) + " " + str(start[1]))
	print("End = " + str(end[0]) + " " + str(end[1]))
	var y = (-(end[1] - start[1])*4) * POWER
	var x = (-(end[0] - start[0])  ) * POWER
	print("X = " + str(x))
	print("Y = " + str(y))
	jump(x, y)


var startpos = null
var endpos = null

func _input(event: InputEvent):
	if event is InputEventScreenTouch: 
		if event.is_pressed():
			startpos = event.get_position()
		if event.is_released():
			endpos = event.get_position()
			_launch(startpos, endpos)
	if event is InputEventScreenDrag:
		#position.x = event.get_position().x
		#position.y = event.get_position().y
		print(event.get_position())
	return
	
		
func jump(x, y):
	velocity.y += y
	velocity.x += x
# Called every frame. 'delta' is the elapsed time since the previous frame.
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
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	else:
		velocity.x = move_toward(velocity.x, 0, 5)

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	#else:
		#velocity.x = move_toward(velocity.x, 0, 2)

	move_and_slide()
	
