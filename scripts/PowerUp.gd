extends RigidBody2D
#dictionary of power (sprite_name: power_function)
var power_dict = {}
signal paddle_size_up
signal paddle_size_down

func _ready():
	#functions for dictionary
	var pdl_wide_func = funcref(self, "on_pdl_wide")
	var pdl_small_func = funcref(self, "on_pdl_small")
	
	#initialize dictionary
	power_dict["pdl_wide"] = pdl_wide_func
	power_dict["pdl_small"] = pdl_small_func

func _on_PowerUp_body_enter( body ):
	if (body.get_name() == "ball"):
		#call function based on current animation name
		if (body.get_linear_velocity().x > 0):
			power_dict[get_node("sprite").get_animation()].call_func("left")
		else:
			power_dict[get_node("sprite").get_animation()].call_func("right")

func on_pdl_wide(paddle):
	emit_signal("paddle_size_up", [paddle])
	
func on_pdl_small(paddle):
	emit_signal("paddle_size_down", [paddle])
	
