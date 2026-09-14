extends Camera2D
var player = null
var smoothingSpeed = 200

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_parent().get_node("Player")
	smoothingSpeed = 120.0 



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	global_position = global_position.move_toward(player.global_position, smoothingSpeed * (global_position.distance_to(player.global_position) / 100) * delta)
