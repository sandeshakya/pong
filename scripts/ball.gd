extends RigidBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	set_bounce(1)
	set_friction(0)
	set_mode(MODE_CHARACTER)
	set_gravity_scale(0)
	set_linear_damp(0.0)
	set_angular_damp(0.0)

