extends Control


var remaining : int setget set_remaining
var delivered : int setget set_delivered

onready var v_remaining = $vRemaining
onready var v_delivered = $vDelivered

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func set_remaining(v):
	remaining = v
	v_remaining.text = str(v)

func set_delivered(v):
	delivered = v
	v_delivered.text = str(v)