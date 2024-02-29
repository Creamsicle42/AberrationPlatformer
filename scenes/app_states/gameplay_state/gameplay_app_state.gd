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