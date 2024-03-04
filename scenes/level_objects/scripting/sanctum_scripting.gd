extends Node


@export var first_entry_executor : EventExecutor
@export var additional_entry_executor : EventExecutor
@export var bad_ending_executor : EventExecutor
@export var good_ending_executor : EventExecutor


func _on_player_entered_room_body_entered() -> void:
    if not GameDataManager.current_game_data.flags.get("abberation_created", false):
        first_entry_executor.execute()
        return
    
    if GameDataManager.current_game_data.flags.get("gems_collected", 0) == 12:
        good_ending_executor.execute()
        return
    
    if GameDataManager.current_game_data.flags.get("gems_collected", 0) >= 8:
        bad_ending_executor.execute()
        return
    
    additional_entry_executor.execute()
    

