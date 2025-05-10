extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _launch(start:Vector2, end:Vector2):
	print("Start = " + str(start[0]) + " " + str(start[1]))
	print("End = " + str(end[0]) + " " + str(end[1]))
	#var power = sqrt(pow((start[0] - end[0]), 2) + pow((start[1] - end[1]), 2))
	var y = (start[0] - end[0])
	var x = (start[1] - end[1])
	print("X = " + str(x))
	jump(x, y)
	return
	#power = sqrt(())


var startpos = null
var endpos = null

func _input(event: InputEvent):
	if not event is InputEventScreenTouch:
		return 
	if event.is_pressed():
		startpos = event.get_position()
	if event.is_released():
		endpos = event.get_position()
		_launch(startpos, endpos)
		
func jump(x, y):
	velocity.y = y
	velocity.x = x
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
