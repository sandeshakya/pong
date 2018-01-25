extends Node2D
var left_position = Vector2()
var right_position = Vector2()
var middle_position = Vector2()
onready var left = get_node("left")
onready var right = get_node("right")
onready var ball = get_node("ball")
onready var separator = get_node("seperator")
onready var p1_score_lbl = get_node("p1_score")
onready var p2_score_lbl = get_node("p2_score")
onready var pwr_up_scene = load("res://scenes/PowerUp.tscn")
onready var power_spawn_timer = get_node("power_spawn_timer")
var p1_score
var p2_score
var size
var pwr_up_time = [10,20]

func _ready():
	randomize()
	size = get_viewport_rect().size
	#setting object positions
	left_position = Vector2(size.x/10, size.y/2)
	right_position = Vector2(size.x/10*9, size.y/2)
	middle_position = Vector2(size/2)
	
	left.set_pos(left_position)
	right.set_pos(right_position)
	separator.set_pos(middle_position)
	ball.set_pos(middle_position)
	p1_score_lbl.set_pos(Vector2(5,5))
	p2_score_lbl.set_pos(Vector2(size.x - 2*p2_score_lbl.get_size().x-5, 5))
	p1_score = 0
	p2_score = 0
	#set timer stuff
	power_spawn_timer.set_wait_time(rand_range(pwr_up_time[0], pwr_up_time[1]))
	power_spawn_timer.start()
	power_spawn_timer.connect("timeout", self, "_on_timer_timeout")
	ball.connect("ball_out", self, "_on_ball_out")
	set_fixed_process(true)
	
func _fixed_process(delta):
	# start spawning 
	if (Input.is_action_pressed("ui_action") and ball.get_linear_velocity().length() > 0):
		power_spawn_timer.start()

func _on_ball_out(arg):
	var position = arg[0]
	if (position < 0):
		p2_score += 1
		p2_score_lbl.set_text(str(p2_score))
	elif (position > get_viewport_rect().size.x):
		p1_score += 1
		p1_score_lbl.set_text(str(p1_score))
	#center ball
	ball.set_pos(middle_position)
	#erase all power ups and stop spawing when ball out
	power_spawn_timer.stop()
	for child in get_children():
		if ("power_ups" in child.get_groups()):
			child.queue_free()
	make_normal()

func make_normal():
	left.set_scale(Vector2(1,1))
	right.set_scale(Vector2(1,1))

func _on_paddle_size_up(args):
	var player = args[0]
	get_node(player).set_scale(Vector2(1,1.5))

func _on_paddle_size_down(args):
	get_node(args[0]).set_scale(Vector2(1,0.5))
	power_life_helper(3, "nrml_pdl", args[0])
	
func _on_timer_timeout():
	#dont spawn in ball is not being played
	if (ball.get_pos().length() == 0): pass
	var pwr_up = pwr_up_scene.instance()
	pwr_up.connect("paddle_size_up", self, "_on_paddle_size_up")
	pwr_up.connect("paddle_size_down", self, "_on_paddle_size_down")
	pwr_up.set_pos(Vector2(rand_range(size.x/3, size.x*2/3), rand_range(size.y/3, size.y*2/3)))
	add_child(pwr_up)
	pwr_up.add_to_group("power_ups")
	power_spawn_timer.set_wait_time(rand_range(pwr_up_time[0], pwr_up_time[1]))
