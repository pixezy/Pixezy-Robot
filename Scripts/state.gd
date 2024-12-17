class_name State
extends Node
@export_group("StateMachine")
@export var stateName:String
@export var stateParameter:String
@export var stateData:StateData

@export_group("CharacterB3D")
@export var velocityMultiplier:float

@onready var state_machine:StateMachine = get_node(stateData.stateMachine)
@onready var characterB3D:CharacterBody3D = get_node(stateData.character)
@onready var animationTree:AnimationTree = get_node(stateData.animationTree)
@onready var view:Node3D = get_node(stateData.view)
@onready var smPlaybackPath:String = stateData.smPlaybackPath

func handle_input(_event: InputEvent) -> void:
	pass
	
func update(_delta:float) -> void: 
	pass

func physics_update(_delta: float)-> void: 
	pass

func enter(_msg:Dictionary={})->void: 
	pass

func exit() -> void: 
	pass
