extends CharacterBody2D


const SPEED = 500.0
const sprintSpeed = 700
var curSpeed = SPEED
const JUMP_VELOCITY = -400.0
var wasFalling
@onready var tap = $Thump
@onready var scrape = $scrape
@onready var particles = $particles

var shouldBePlayingScrape = false
func _physics_process(delta: float) -> void:
	if global_position.y > 3000:
		get_tree().reload_current_scene()
	if not is_on_floor():
		if velocity.y > 0:
			wasFalling = true
	else:
			if wasFalling:
				tap.play()
				wasFalling = false
	
	if Input.is_action_pressed("sprint"):
		curSpeed = sprintSpeed
	else:
		curSpeed = SPEED
		
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	if is_on_floor() && velocity.x != 0 && !scrape.is_playing():
		scrape.play()
		particles.emitting = true
	elif !is_on_floor() || velocity.x == 0:
		scrape.stop()
		particles.emitting = false
	# Handle jump.
	if Input.is_action_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * curSpeed
	else:
		velocity.x = move_toward(velocity.x, 0, curSpeed)

	move_and_slide()
