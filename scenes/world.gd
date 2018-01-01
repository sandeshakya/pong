extends Node2D
var left_position = Vector2()
var right_position = Vector2()
var ball_position = Vector2()
var separator_position = Vector2()
var left
var right
var ball
var separator

func _ready():
	left = get_node("left")
	right = get_node("right")
	ball = get_node("ball")
	separator = get_node("seperator")
	
	var size = get_viewport_rect().size
	#setting object positions
	left_position = Vector2(size.x/10, size.y/2)
	right_position = Vector2(size.x/10*9, size.y/2)
	ball_position = Vector2(size.x/2, size.y/2)
	separator_position = Vector2(size.x/2, size.y/2)
	
	left.set_pos(left_position)
	right.set_pos(right_position)
	separator.set_pos(separator_position)
	ball.set_pos(ball_position)
	pass
