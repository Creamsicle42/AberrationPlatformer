class_name GameplayAppState
extends Node


## GameplayAppState, Controlls the gameplay half of the game
##
## Handles level advancing, resetting, and returning to the main menu when needed


@export var level_manager : LevelManager
@export var pause_menu : PauseMenu



var is_game_paused := false


func _input(event: InputEvent) -> void:
    if event.is_action_pressed("ui_cancel"):
        set_game_paused(not is_game_paused)



func enter_state(params : Dictionary) -> void:
    var start_level_index = params.get("start_level", 0)
    GameDataManager.current_game_data.level_on = start_level_index
    level_manager.set_level_index(start_level_index)
    level_manager.instance_current_level()
    set_game_paused(false)


func exit_state() -> void:
    pass


func player_reached_end_of_game() -> void:
    Main.app.set_state("main_menu")


func set_game_paused(paused : bool) -> void:
    is_game_paused = paused
    pause_menu.visible = paused
    get_tree().paused = paused
    #level_manager.current_level_node.set_deferred("process_mode", Node.PROCESS_MODE_DISABLED if paused else Node.PROCESS_MODE_INHERIT)


func _on_event_bus_player_killed() -> void:
    level_manager.instance_current_level()


func _on_event_bus_end_goal_reached() -> void:
    var more_levels_exist = level_manager.advance_level()

    if not more_levels_exist: 
        player_reached_end_of_game()
        return
    else:
        level_manager.instance_current_level()
        GameDataManager.save_game_data()


func _on_pause_menu_restart_level_pressed() -> void:
    level_manager.instance_current_level()
    set_game_paused(false)


func _on_pause_menu_next_level_pressed() -> void:
    var more_levels_exist = level_manager.advance_level()

    if not more_levels_exist: 
        player_reached_end_of_game()
        return
    else:
        level_manager.instance_current_level()
        GameDataManager.save_game_data()


func _on_pause_menu_go_to_main_menu_pressed() -> void:
    Main.app.set_state("main_menu")


func _on_pause_menu_continue_pressed() -> void:
    set_game_paused(false)
