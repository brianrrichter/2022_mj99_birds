extends Area2D


export var type : int = 0

signal delivered()

func start(__position, __type):
	position = __position
	type = __type

# Called when the node enters the scene tree for the first time.
func _ready():
	$Mail.frame = type
	pass # Replace with function body.

func been_delivered():
	emit_signal("delivered")
	queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
