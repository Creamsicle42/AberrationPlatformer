class_name GameplayAppState
extends Node


## GameplayAppState, Controlls the gameplay half of the game
##
## Handles level advancing, resetting, and returning to the main menu when needed


@export var level_manager : LevelManager


func enter_state(params : Dictionary) -> void:
    var start_level_index = params.get("start_level", 0)
    level_manager.set_level_index(start_level_index)
    level_manager.instance_current_level()


func exit_state() -> void:
    pass


func player_reached_end_of_game() -> void:
    pass


func _on_event_bus_player_killed() -> void:
    level_manager.instance_current_level()


func _on_event_bus_end_goal_reached() -> void:
    var more_levels_exist = level_manager.advance_level()

    if not more_levels_exist: 
        player_reached_end_of_game()
        return
    else:
        level_manager.instance_current_level()