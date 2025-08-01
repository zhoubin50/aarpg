class_name Player extends CharacterBody2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var state_machine: PlayerStateMachine = $StateMachine

var DIR_4 =[Vector2.RIGHT,Vector2.DOWN,Vector2.LEFT,Vector2.UP]

signal direction_changed(new_direction:Vector2)


var direction:Vector2=Vector2.ZERO
#var move_speed:float=100.0
#var state:String='idle'
var cardinal_direction:Vector2=Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	state_machine.initialize(self)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#direction.x=Input.get_action_strength('right')-Input.get_action_strength('left')
	#direction.y=Input.get_action_strength('down')-Input.get_action_strength('up')
	#direction=direction.normalized()
	# 更好的实现方式
	direction = Vector2(
		Input.get_axis("left","right"),
		Input.get_axis("up","down")
	).normalized()
	#velocity=direction*move_speed
	#if set_state() || set_direction():
		#update_animation()
	
	
func _physics_process(delta: float) -> void:
	move_and_slide()


func set_direction()->bool:
	#var new_direction :Vector2=cardinal_direction
	if direction==Vector2.ZERO:
		return false
	#if direction.y==0:
		#new_direction = Vector2.LEFT if direction.x<0 else Vector2.RIGHT
	#if direction.x==0:
		#new_direction = Vector2.UP if direction.y<0 else Vector2.DOWN
	# 方向计算，需要研究下
	var direction_id:int = int(round((direction+cardinal_direction*0.1).angle()/TAU*DIR_4.size()))
	var new_direction = DIR_4[direction_id]
	if new_direction==cardinal_direction:
		return false
	cardinal_direction=new_direction
	direction_changed.emit(new_direction)
	sprite_2d.scale.x = -1 if cardinal_direction==Vector2.LEFT else 1
	return true


#func set_state()->bool:
	#var new_state:String = 'idle' if direction==Vector2.ZERO else 'walk'
	#if new_state==state:
		#return false
	#state = new_state
	#return true

func update_animation(state:String):
	animation_player.play(state+'_'+animation_direction())
	
	
func animation_direction()->String:
	if cardinal_direction==Vector2.DOWN:
		return 'down'
	elif cardinal_direction==Vector2.UP:
		return 'up'
	else:
		return 'side'
