extends Area2D

func _ready():
	pass

func _on_PowerUp_body_enter( body ):
	print(body.get_linear_velocity())
	var player
	if(body.get_linear_velocity().x > 0):
		player = "left"
	else:
		player = "right"
	print(player)
	signalManager.emit_signal("power_up_consumed",[player])