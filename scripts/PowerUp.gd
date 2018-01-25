extends Area2D
#dictionary of power (sprite_name: power_function)
var power_dict = {}
signal paddle_size_up
signal paddle_size_down
export (int, 3, 7) var speed = 5
var dir = 1

func _ready():
	#functions for dictionary
	var pdl_wide_func = funcref(self, "on_pdl_wide")
	var pdl_small_func = funcref(self, "on_pdl_small")
	
	#initialize dictionary
	power_dict["pdl_wide"] = pdl_wide_func
	power_dict["pdl_small"] = pdl_small_func
	set_fixed_process(true)

func _fixed_process(delta):
#	Bounce power up vertically
#	var pos = get_pos()
#	if ((get_pos().y <= 0) or (get_pos().y >= get_viewport_rect().size.y)):
#		dir *= -1
#	pos.y += speed * dir
#	set_pos(pos)
	pass

func _on_PowerUp_body_enter( body ):
	if (body.get_name() == "ball"):
		#call function based on current animation name
		if (body.get_linear_velocity().x > 0):
			power_dict[get_node("sprite").get_animation()].call_func("left")
		else:
			power_dict[get_node("sprite").get_animation()].call_func("right")
		self.queue_free()

func on_pdl_wide(paddle):
	emit_signal("paddle_size_up", [paddle])
	
func on_pdl_small(paddle):
	emit_signal("paddle_size_down", [paddle])

