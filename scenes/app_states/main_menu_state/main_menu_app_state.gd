class_name MainMenuAppState
extends Node


func enter_state(_params:Dictionary) -> void:
    pass


func exit_state() -> void:
    pass


func _on_play_button_pressed() -> void:
    Main.app.set_state("gameplay")
