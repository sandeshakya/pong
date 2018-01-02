extends Node2D
var left_position = Vector2()
var right_position = Vector2()
var middle_position = Vector2()
var p1_score_position = Vector2()
var p2_score_position = Vector2()
onready var left = get_node("left")
onready var right = get_node("right")
onready var ball = get_node("ball")
onready var separator = get_node("seperator")
onready var p1_score_lbl = get_node("p1_score")
onready var p2_score_lbl = get_node("p2_score")
var p1_score
var p2_score

func _ready():
	var size = get_viewport_rect().size
	#setting object positions
	left_position = Vector2(size.x/10, size.y/2)
	right_position = Vector2(size.x/10*9, size.y/2)
	middle_position = Vector2(size/2)
	p1_score_position = Vector2(0, 0)
	p2_score_position = Vector2(size.x - 2*p2_score_lbl.get_size().x, 0)
	
	left.set_pos(left_position)
	right.set_pos(right_position)
	separator.set_pos(middle_position)
	ball.set_pos(middle_position)
	p1_score_lbl.set_pos(p1_score_position)
	p2_score_lbl.set_pos(p2_score_position)
	
	p1_score = 0
	p2_score = 0
	ball.connect("ball_out", self, "_on_ball_out")
	set_fixed_process(true)

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
