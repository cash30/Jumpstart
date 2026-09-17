extends CharacterBody2D

@onready var thump_sound = $AudioStreamPlayer2D

var was_falling = false

func _physics_process(delta):
	if not is_on_floor():
		if velocity.y > 0:
			was_falling = true
	else:
		if was_falling:
			thump_sound.play()
			was_falling = false

	move_and_slide()
