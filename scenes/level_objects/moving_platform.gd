class_name MovingPlatform
extends PathFollow2D


@export var auto_start := true
@export var loop_movement := true
@export var targets : Array[MovingPlatformTweenTarget]


func _ready() -> void:
	if auto_start: start_animation()


func start_animation() -> void:
	var tweener = create_tween()
	if loop_movement: tweener.set_loops()
	for target : MovingPlatformTweenTarget in targets:
		tweener.tween_property(self, "progress_ratio", target.target, target.duration).set_trans(target.trans_type).set_ease(target.ease_type)