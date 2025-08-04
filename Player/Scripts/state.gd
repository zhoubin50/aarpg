class_name State extends Node

static var player:Player
static var state_machine:PlayerStateMachine


func init()->void:
	pass

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func enter()->void:
	pass
	
	
func exit()->void:
	pass
	
	
func process(_delta:float)->State:
	return null
	
	
func physics_process(_delta:float)->State:
	return null
	
	
func handle_input(_event:InputEvent)->State:
	return null
