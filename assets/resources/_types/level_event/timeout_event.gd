class_name TimeoutEvent
extends LevelEvent


@export var time : float


func execute(data: Dictionary) -> void:
    await (data.caller as Node).get_tree().create_timer(time).timeout