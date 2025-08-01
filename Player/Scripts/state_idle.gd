class_name StateIdle extends State
@onready var walk: State = $"../Walk"
@onready var attack: State = $"../Attack"


# 进入该状态会做些神马
func enter()->void:
	player.update_animation('idle')
	
	
func exit()->void:
	pass
	
	
func process(_delta:float)->State:
	if player.direction !=Vector2.ZERO:
		return walk
	player.velocity=Vector2.ZERO
	return null
	
	
func physics_process(_delta:float)->State:
	return null
	
	
func handle_input(_event:InputEvent)->State:
	if _event.is_action_pressed("attack"):
		return attack
	return null
