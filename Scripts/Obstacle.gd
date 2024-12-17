extends StaticBody3D
@onready var rayNode:RayC = %RayC
@onready var mi:MeshInstance3D = get_node("MeshInstance3D")
var isColliding:bool = false
var opacity:float = 1.0

func _ready() -> void:
	rayNode.colliding.connect(collide)

func collide(instance_id:int) -> void: 	
	isColliding = instance_id == get_instance_id()
		
func _process(delta: float) -> void:
	if isColliding:
		opacity = lerpf(opacity,0.0,delta * 5)
	else:
		opacity = lerpf(opacity,1.0,delta * 2)	
	set_opacity()
	
func set_opacity()-> void:
	mi.set_instance_shader_parameter("opacity",opacity)

