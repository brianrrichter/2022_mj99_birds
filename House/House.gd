extends Area2D


export var type : int = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	$Houses.frame = type
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
