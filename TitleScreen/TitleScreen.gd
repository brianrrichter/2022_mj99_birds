extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var _r = $PlayButton.connect("pressed", self, "on_play_pressed")
	pass # Replace with function body.

func on_play_pressed():
	get_tree().change_scene("res://Main.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
