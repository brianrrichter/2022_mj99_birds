extends Area2D

var MOVE_SPEED = 250.0
var velocity = Vector2.ZERO
var direction

func start(__position, __target_position):
	position = __position
	direction = (__target_position - position).normalized()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += MOVE_SPEED * direction * delta
