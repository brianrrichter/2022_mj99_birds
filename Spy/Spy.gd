extends Area2D


const shot_scn = preload("res://Shot/Shot.tscn")

var target

func start(__position, __target):
	position = __position
	target = __target

# Called when the node enters the scene tree for the first time.
func _ready():
	var _r = $AnimatedSprite.connect("animation_finished", self, "_on_animation_finished")
	$AnimatedSprite.play("default")
	pass # Replace with function body.

func _on_animation_finished():
	var shot = shot_scn.instance()
	shot.start(position, target.position)
	get_parent().get_parent().add_child(shot)
	queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass




