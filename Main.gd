extends Node2D

enum Status {
	RUNNING,
	FINISHED
}

const mail_scn = preload("res://Mail/Mail.tscn")
const detector_scn = preload("res://Detector/Detector.tscn")
const spy_scn = preload("res://Spy/Spy.tscn")
const level_finished_scn = preload("res://LevelUi/LevelFinished.tscn")

# var spawner = []
# var mail_pool = [] #mail_box_id, mail_type
export(Array, Array, int) var mail_pool = [[0, 0]]

export(String) var next_scene

var pool_original_size = 0
var status = Status.RUNNING

onready var mail_timer = $MailTimer
onready var level_timer = $LevelTimer
onready var mail_conteiner = $MailYSort
onready var player = $Player
onready var spy_conteiner = $SpyConteiner
onready var mail_box_conteiner = $MailBoxYSort
onready var levelUi = $LevelUi



# Called when the node enters the scene tree for the first time.
func _ready():
#	$AnimationPlayer.play("speaking")

	
	mail_timer.connect("timeout", self, "_on_mail_timeout")
	level_timer.connect("timeout", self, "_on_level_timer_timeout")
	
	level_timer.one_shot = true

	mail_timer.start()
	level_timer.start()


	player.connect("stop_moving", self, "_on_player_stop_moving")

	# mail_pool.append([0,0])
	# mail_pool.append([1,1])
	# mail_pool.append([0,2])
	# mail_pool.append([1,0])
	
	pool_original_size = mail_pool.size()
	
	levelUi.remaining = mail_pool.size()
	
	_on_mail_timeout()

	pass # Replace with function body.


func _on_mail_timeout():
	if mail_conteiner.get_child_count() >= 3:
		return

	if mail_pool.empty() and mail_conteiner.get_child_count() <= 0:
		levelFinished()

	var mail_item = mail_pool.pop_front()
	levelUi.remaining = mail_pool.size()

	if mail_item != null:
		var mail_box = get_mail_box_by_id(mail_item[0])

		if mail_box != null:
			var m = mail_scn.instance()
			m.start(_next_free_spot(mail_box.position), mail_item[1])
			m.connect("delivered", self, "on_mail_delivered")
			mail_conteiner.add_child(m)

func get_mail_box_by_id(mail_box_id):
	for b in mail_box_conteiner.get_children():
		if b.id == mail_box_id:
			return b
	return null

func _next_free_spot(pos):
	var space_state = get_world_2d().direct_space_state
	var result = space_state.intersect_point(pos, 32, [], 0x7FFFFFFF, true, true ) # 15: TYPE_MASK_AREA

	if !result.empty():
		return _next_free_spot(pos + Vector2(64, 0))
	
	return pos

func on_mail_delivered():
	# levelUi.remaining = mail_conteiner.get_child_count() + mail_pool.size()
	levelUi.delivered += 1
	if levelUi.delivered == pool_original_size:
		levelFinished()

func _on_player_stop_moving():
	if spy_conteiner.get_child_count() <= 0:
		var spy = spy_scn.instance()
		var pos = (player.position + Vector2(100,100))
		pos = Vector2(int(pos.x) % 1024, int(pos.y) % 576)
		spy.start(pos, player)
		spy_conteiner.add_child(spy)

func levelFinished():
	if status == Status.FINISHED:
		return;
	
	status = Status.FINISHED
	var inst = level_finished_scn.instance()
	var delivered = levelUi.delivered
#	inst.start(pool_original_size, delivered)

	inst.connect("next_scene_clicked", self, "go_next_level")
	inst.connect("play_again_clicked", self, "play_again")

	add_child(inst)
	inst.total = pool_original_size
	inst.delivered = delivered
	inst.has_next_level = next_scene != null and !next_scene.empty()
	pass;

func go_next_level():
	if next_scene != null and !next_scene.empty():
		var _r = get_tree().change_scene(next_scene)


func play_again():
	var _r = get_tree().reload_current_scene()

func _on_level_timer_timeout():
	levelFinished()



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	levelUi.time_left = level_timer.time_left
	pass

