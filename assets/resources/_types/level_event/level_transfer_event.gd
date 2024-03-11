class_name LevelTransferEvent
extends LevelEvent


@export var level_name : String
@export var checkpoint_name : String


func execute(_data : Dictionary) -> void:
    GameplayEventBus.bus.player_warp_needed.emit(level_name, checkpoint_name)