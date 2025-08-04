class_name HurtBox extends Area2D


@export var damage:int=1
#@export var effect

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	area_entered.connect(_on_area_entered)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_area_entered(area:Area2D):
	if area is HitBox:
		area.take_damage(self)
