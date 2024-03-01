class_name FlipPivot
extends Node2D


@export var flip_base : CharacterBody2D


var is_facing_right := true


func _physics_process(_delta: float) -> void:
	if is_facing_right and flip_base.velocity.x < 0:
		is_facing_right = false
		scale.x = -1
	if not is_facing_right and flip_base.velocity.x > 0:
		is_facing_right = true
		scale.x = 1