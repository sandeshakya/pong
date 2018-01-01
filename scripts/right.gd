extends KinematicBody2D
var screen_size
var pad_size
var speed = 5
var accelaration

func _ready():
	set_fixed_process(true)

func _fixed_process(delta):
	var posy = get_pos().y
	var direction = Input.is_action_pressed("ui_down") - Input.is_action_pressed("ui_up")
	if (direction != 0):
		posy += direction * speed
	posy = clamp(posy, 0, 300)
	set_pos(Vector2(get_pos().x, posy))
