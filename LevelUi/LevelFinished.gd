extends Control

var total setget set_total
var delivered setget set_delivered
var has_next_level setget set_has_next_level

onready var v_total = $vTotal
onready var v_delivered = $vDelivered

signal play_again_clicked()
signal next_scene_clicked()

#func start(__total, __delivered):
#	set_total(__total)
#	set_delivered(__delivered)


# Called when the node enters the scene tree for the first time.
func _ready():
	var _r = $nextLevelButton.connect("pressed", self, "_on_next_scene_clicked")
	_r = $playAgainButton.connect("pressed", self, "_on_play_again_pressed")
	_r = $titleScreenButton.connect("pressed", self, "_on_title_button_pressed")
	pass # Replace with function body.

func set_total(v):
	total = v
	v_total.text = str(v)
	
func set_delivered(v):
	delivered = v
	v_delivered.text = str(v)

func set_has_next_level(v):
	has_next_level = v
	
	if !v:
		$nextLevelButton.hide()
	
	
	
func _on_next_scene_clicked():
	emit_signal("next_scene_clicked")
#	get_tree().change_scene("res://Main.tscn")

func _on_play_again_pressed():
	emit_signal("play_again_clicked")
#	get_tree().change_scene("res://Main.tscn")
	
func _on_title_button_pressed():
	var _r = get_tree().change_scene("res://TitleScreen/TitleScreen.tscn")
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
