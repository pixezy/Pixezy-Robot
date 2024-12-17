#--- Locomotion
extends State
var lerpVelocity:Vector3 = Vector3.ZERO

func enter(_msg:Dictionary = {}) -> void:	
	var playback:AnimationNodeStateMachinePlayback = animationTree.get(smPlaybackPath)
	playback.travel(stateName)
	#if _msg.has("velocity"):	
		#pass		

func physics_update(delta:float) -> void:
	#--- Movement
	characterB3D.move_and_slide()	
	var velocity:Vector3
	velocity.x = Input.get_axis("move_right","move_left")
	velocity.z = Input.get_axis("move_back","move_forward")	
	
	var viewVelocity:Vector3 = velocity.rotated(Vector3.UP,view.rotation.y)
	viewVelocity = viewVelocity.normalized()
	lerpVelocity = lerp(characterB3D.velocity, viewVelocity * velocityMultiplier, delta * 3.0)
	characterB3D.velocity = lerpVelocity

	#--- Animation
	var animationVelocity:float = (lerpVelocity.length()/velocityMultiplier)
	animationTree.set(stateParameter,animationVelocity) 
	
	#--- Rotation
	var rotation_direction:float
	if Vector2(viewVelocity.z, viewVelocity.x).length() > 0.0: 
		rotation_direction = Vector2(viewVelocity.z, viewVelocity.x).angle()
		characterB3D.rotation.y = lerp_angle(characterB3D.rotation.y, rotation_direction, delta * 10)	
	
	#--- Exit conditions
	if Input.is_action_pressed("strafe_left") or Input.is_action_pressed("strafe_right"):
		state_machine.transition_to("Strafe")
	
	if(lerpVelocity.length() < 0.01):
		state_machine.transition_to("Idle")
	
