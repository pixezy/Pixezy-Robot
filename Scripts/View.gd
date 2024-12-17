extends Node3D

@export_group("Properties")
@export var target: Node3D
@export var yPosition: float

@export_group("Zoom")
@export var zoom_minimum:float = 16
@export var zoom_maximum:float = 4
@export var zoom_speed:float = 10

@export_group("Rotation")
@export var rotation_speed:float = 120

var camera_rotation:Vector3
var zoom:float = 5

@onready var camera:Camera3D = %Camera3D

func _ready() -> void: 
	camera_rotation = rotation_degrees

func _physics_process(delta: float) -> void:
	if target:
		position = position.lerp(target.position + Vector3(0,yPosition,0), delta * 4)
	rotation_degrees = rotation_degrees.lerp(camera_rotation, delta * 6)
	camera.position = camera.position.lerp(Vector3(0,0,-zoom),8 * delta)
	handle_input(delta)

func handle_input(delta:float) -> void: 
	#--- Rotation
	var input:Vector3 = Vector3.ZERO
	input.y = Input.get_axis("camera_left", "camera_right")
	input.x = Input.get_axis("camera_down", "camera_up")
	
	camera_rotation += input.limit_length(1.0) * rotation_speed * delta
	camera_rotation.x = clamp(camera_rotation.x, 0,80)
	
	#--- Zooming
	zoom += Input.get_axis("zoom_out", "zoom_in") * zoom_speed * delta
	zoom = clamp(zoom, zoom_maximum, zoom_minimum)
	
	
	
