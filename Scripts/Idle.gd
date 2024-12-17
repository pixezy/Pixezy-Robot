#--- Idle
extends State

func enter(_msg:Dictionary = {}) -> void:
	characterB3D.velocity = Vector3.ZERO

func update(_delta:float) -> void:
	var velocity:Vector2 = Input.get_vector("move_left","move_right","move_back","move_forward")
	
	#--- Exit conditions
	if Input.is_action_pressed("strafe_left") or Input.is_action_pressed("strafe_right"):
		state_machine.transition_to("Strafe")	
	
	if velocity.length() > 0.01:
		state_machine.transition_to("Locomotion")
	
