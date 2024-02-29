class_name MainMenuAppState
extends Node


func enter_state(_params:Dictionary) -> void:
    pass


func exit_state() -> void:
    pass


func _on_play_button_pressed() -> void:
    Main.app.set_state("gameplay", {
        "start_level": 0 if GameDataManager.current_game_data.level_on == -1 else GameDataManager.current_game_data.level_on
    })
