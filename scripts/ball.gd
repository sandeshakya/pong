extends RigidBody2D
signal ball_out
var isStationary = true
var spd_up = 50
var max_spd = 400
var min_spd = 200
var ball_dir
func _ready():
	randomize()
	#setting random initial ball direction
	ball_dir = randi()%2
	if (ball_dir==0):
		ball_dir = -1 
	set_bounce(1)
	set_friction(0)
	set_mode(MODE_CHARACTER)
	set_gravity_scale(0)
	set_linear_damp(0.0)
	set_angular_damp(0.0)
	set_up_ball()
	set_fixed_process(true)
	
func _fixed_process(delta):
	# start game
	if (isStationary and Input.is_action_pressed("ui_action")):
		set_linear_velocity(Vector2(min_spd*ball_dir,0))
		isStationary = false
	if (get_linear_velocity().length() > max_spd+1):
		print(str(get_linear_velocity().length()))
		print(str(get_pos()))
	#collisions
	var bodies = get_colliding_bodies()
	for body in bodies:
		#if ball collides with paddle
		if (body.get_name() == "left" or body.get_name() == "right"):
			var speed = get_linear_velocity().length()
			speed = clamp(speed + spd_up, min_spd, max_spd)
			var dir = get_pos() - body.get_node("anchor").get_global_pos()
			var vel = speed * dir.normalized()
			set_linear_velocity(vel)
	
	#if ball is out of bounds, ball goes towards winner
	if ((get_pos().x < 0) or (get_pos().x > get_viewport_rect().size.x)):
		#pos-1 returns -1 to size-1, clamp returns -1 or 1
		#reverse to give ball to winner
		ball_dir = clamp(get_pos().x - 1, -1, 1) * -1
		emit_signal("ball_out", [get_pos().x])
		set_up_ball()

func set_up_ball():
	set_linear_velocity(Vector2(0,0))
	isStationary = true
