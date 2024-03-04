class_name SetFlagEvent
extends LevelEvent


@export var flag_id : String
@export var value : bool


func execute(_data : Dictionary) -> void:
    GameDataManager.current_game_data.flags[flag_id] = value