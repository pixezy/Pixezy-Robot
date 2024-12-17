class_name StateMachine
extends Node

signal transitioned(state_name:String)

@export var current_state:State 
var states : Dictionary = {}

func _ready() -> void: 
	await owner.ready
	
	for child:State in get_children():
		child.state_machine = self
		states[child.name] = child
	current_state.enter()
	
func _unhandled_input(event: InputEvent) -> void:
	current_state.handle_input(event)

func _process(delta: float) -> void:
	current_state.update(delta)
	
func _physics_process(delta: float) -> void:
	current_state.physics_update(delta)

func transition_to(target_state_name: String, msg: Dictionary = {}) -> void: 
	if not states.has(target_state_name):
		return
	current_state.exit()
	current_state = states[target_state_name]
	current_state.enter(msg)
	emit_signal("transitioned",current_state.name)
	
