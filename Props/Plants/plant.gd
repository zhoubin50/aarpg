class_name Plant extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$HitBox.damaged.connect(take_damage)


func take_damage(hurt_box:HurtBox)->void:
	queue_free()
