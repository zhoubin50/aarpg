class_name PlayerStateMachine extends Node

var states:Array[State]
var prev_state:State
var current_state:State

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Node.PROCESS_MODE_DISABLED

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	change_state(current_state.process(delta))
	
	
func _physics_process(delta: float) -> void:
	change_state(current_state.physics_process(delta))
	
	
func _unhandled_input(event: InputEvent) -> void:
	change_state(current_state.handle_input(event))
	
	
func initialize(_player:Player)->void:
	states=[]
	for c in get_children():
		if c is State:
			states.append(c)
	if states.size()>0:
		states[0].player=_player
		change_state(states[0])
		Node.PROCESS_MODE_INHERIT


# 改变状态，先判断新状态是否为空或者新状态与当前状态相同，如果判断为真，则不改变状态
# 否则，先退出当前状态，再进入新状态
func change_state(new_state:State)->void:
	if new_state==null || new_state==current_state:
		return
	if current_state:
		current_state.exit()
	prev_state=current_state
	current_state=new_state
	new_state.enter()
