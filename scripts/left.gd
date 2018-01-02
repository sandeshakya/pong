extends KinematicBody2D
var screen_height
var pad_size
var speed = 5
var accelaration

func _ready():
	set_fixed_process(true)
	screen_height = get_viewport_rect().size.y

func _fixed_process(delta):
	var posy = get_pos().y
	var direction = Input.is_action_pressed("p2_down") - Input.is_action_pressed("p2_up")
	if (direction != 0):
		posy += direction * speed
	posy = clamp(posy, 0, screen_height)
	set_pos(Vector2(get_pos().x, posy))
