class_name MainMenuAppState
extends Node


@export var continue_button : Button


func enter_state(_params:Dictionary) -> void:
	FadeLayer.fade_in()
	if GameDataManager.current_game_data.level_on == -1:
		continue_button.disabled = true


func exit_state() -> void:
	pass


func _on_new_game_button_pressed() -> void:
	FadeLayer.fade_out()
	await FadeLayer.fade_complete
	Main.app.set_state("gameplay", {
		"start_level": 0
	})


func _on_continue_button_pressed() -> void:
	FadeLayer.fade_out()
	await FadeLayer.fade_complete
	Main.app.set_state("gameplay", {
		"start_level": GameDataManager.current_game_data.level_on
	})
	
