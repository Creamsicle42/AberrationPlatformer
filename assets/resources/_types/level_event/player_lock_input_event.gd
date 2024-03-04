class_name PlayerLockInputEvent
extends LevelEvent


@export var lock_input : bool


func execute(_data : Dictionary) -> void:
    Player.player.set_controlls_locked(lock_input)