extends KinematicBody2D


var MOVE_SPEED = 250.0
var velocity = Vector2.ZERO
var carried_mail = []
var monitor_move = false

onready var sprite = $Sprite
onready var area2d = $Area2D

signal stop_moving()

# Called when the node enters the scene tree for the first time.
func _ready():
	area2d.connect("area_entered", self, "_on_area_entered")
	pass # Replace with function body.


func _physics_process(_delta):

	var weight_discounted = MOVE_SPEED - (50 * carried_mail.size())
	if weight_discounted < 0:
		weight_discounted = 0
	var m_speed = abs(weight_discounted)

	var input_dir = Vector2()
	
	if Input.is_action_pressed("up"):
		input_dir.y -= 1.0
	if Input.is_action_pressed("down"):
		input_dir.y += 1.0
	if Input.is_action_pressed("left"):
		input_dir.x -= 1.0
	if Input.is_action_pressed("right"):
		input_dir.x += 1.0

	if input_dir != Vector2.ZERO:
		velocity = input_dir.normalized() * m_speed
		monitor_move = true

	
		
	if velocity != Vector2.ZERO:
		var ang = velocity.angle() + PI / 2
		sprite.rotation = lerp_angle(sprite.rotation, ang, .5)
	
	
	velocity = move_and_slide(velocity, Vector2.ZERO)

	if velocity == Vector2.ZERO:
		if monitor_move:
			emit_signal("stop_moving")

	if !carried_mail.empty():
		var i : int = 0
		for m in carried_mail:
			m.position = position + Vector2.ONE * (i * 5)
			i += 1

func _unhandled_input(event):
	if event.is_action_pressed("release_load"):
		if !carried_mail.empty():
			carried_mail.pop_back()

func _on_area_entered(area):
	if area.is_in_group("mail"):
		carried_mail.append(area)
	if area.is_in_group("house"):
		# for m in carried_mail:
		# 	if m.type == area.type:
		# 		m.queue_free()
		# 		carried_mail.erase(m)

		# iterate and remove:
		for i in range(carried_mail.size()-1, -1, -1):
			var m = carried_mail[i]
			if m.type == area.type:
				carried_mail.erase(m)
				m.been_delivered()
				# m.queue_free()
	if area.is_in_group("obstacle"):
		if !carried_mail.empty():
			carried_mail.pop_front()
