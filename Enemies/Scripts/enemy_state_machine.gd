class_name EnemyStateMachine extends Node


var states:Array[EnemyState]
var prev_state:EnemyState
var current_state:EnemyState

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	process_mode= Node.PROCESS_MODE_DISABLED

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	change_state(current_state.process(delta))
	
	
func _physics_process(delta: float) -> void:
	change_state(current_state.physics_process(delta))
	
	
func initialize(_enemy:Enemy)->void:
	states=[]
	for c in get_children():
		if c is EnemyState:
			states.append(c)
			
	for s in states:
		s.enemy=_enemy
		s.state_machine=self
		s.init()
		
	if states.size()>0:
		change_state(states[0])
		process_mode = Node.PROCESS_MODE_INHERIT


# 改变状态，先判断新状态是否为空或者新状态与当前状态相同，如果判断为真，则不改变状态
# 否则，先退出当前状态，再进入新状态
func change_state(new_state:EnemyState)->void:
	if new_state==null || new_state==current_state:
		return
	if current_state:
		current_state.exit()
	prev_state=current_state
	current_state=new_state
	new_state.enter()
