class_name StateAttack extends State
@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"
@onready var idle: State = $"../Idle"
@onready var walk: State = $"../Walk"
@onready var attack_animation_player: AnimationPlayer = $"../../Sprite2D/AttackEffectSprite/AnimationPlayer"
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $"../../Audio/AudioStreamPlayer2D"
@onready var hurt_box: HurtBox = %AttackHurtBox


@export var attack_sound:AudioStream
@export_range(1,20,0.5) var decelerate_speed:float=5.0

var attacking:bool=false
# 进入该状态会做些神马
func enter()->void:
	player.update_animation('attack')
	attack_animation_player.play('attack_'+player.animation_direction())
	animation_player.animation_finished.connect(end_attack)
	audio_stream_player_2d.stream=attack_sound
	audio_stream_player_2d.pitch_scale=randf_range(0.9,1.1)
	audio_stream_player_2d.play()
	attacking=true
	await get_tree().create_timer(0.075).timeout
	hurt_box.monitoring=true
	
	
func exit()->void:
	animation_player.animation_finished.disconnect(end_attack)
	attacking=false
	hurt_box.monitoring=false
	
	
func process(_delta:float)->State:
	player.velocity-=player.velocity*decelerate_speed*_delta
	if not attacking:
		if player.direction==Vector2.ZERO:
			return idle
		else:
			return walk
	return null
	
	
func physics_process(_delta:float)->State:
	return null
	
	
func handle_input(_event:InputEvent)->State:
	return null
	
func end_attack(_new_animation:String):
	attacking=false
