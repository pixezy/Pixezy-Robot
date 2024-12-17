class_name RayC
extends Node3D
@export var cam:Camera3D
@export var target:CharacterBody3D

signal colliding(instance_id:int)

func _physics_process(delta: float) -> void:	
	#--- Boilerplate code
	var space_state:PhysicsDirectSpaceState3D = get_world_3d().direct_space_state	
	var origin:Vector3 = cam.project_ray_origin(Vector2.ZERO)
	var query:PhysicsRayQueryParameters3D = PhysicsRayQueryParameters3D \
		.create(origin,target.global_position)
		
	query.exclude  = [target]
	
	#--- Detects only a single object
	var result:Dictionary = space_state.intersect_ray(query)
	var id:int =0; 
	if result:
		id = result["collider_id"]
	colliding.emit(id)
		
		
