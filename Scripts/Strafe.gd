#--- Strafe
extends State
var lerpVelocity:Vector3 = Vector3.ZERO

func enter(_msg:Dictionary = {}) -> void:
	var playback:AnimationNodeStateMachinePlayback = animationTree.get(smPlaybackPath)
	playback.travel(stateName)
	#if _msg.has("velocity"):		
		#pass
		
func physics_update(delta: float)-> void: 
	characterB3D.move_and_slide()
	var strafeVal:float = Input.get_axis("strafe_left","strafe_right")
	var velocity:Vector3 = Vector3(strafeVal,0,0)
	var characterVelocity:Vector3 = characterB3D.basis * velocity
	lerpVelocity = lerp(characterB3D.velocity, characterVelocity * velocityMultiplier,delta * 3.0)	
	characterB3D.velocity = lerpVelocity
	
	var animationVelocity:Vector3 = characterB3D.basis.inverse() * lerpVelocity
	animationTree.set(stateParameter,animationVelocity.x/velocityMultiplier) 
	
	#--- Exit conditions
	if(lerpVelocity.length() < 0.01):
		state_machine.transition_to("Idle")
	
	var wasd:Vector2 = Input.get_vector("move_left","move_right","move_back","move_forward")
	if wasd.length() > 0.01:
		state_machine.transition_to("Locomotion")
