class_name AnimSpriteEffect
extends AnimatedSprite2D


@export var animation_name : String
@export var random_starting_frame : bool
@export var max_frame : int


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	play(animation_name)
	if random_starting_frame: frame = randi_range(0, max_frame)


