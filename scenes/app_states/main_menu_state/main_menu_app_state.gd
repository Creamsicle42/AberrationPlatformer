class_name MainMenuAppState
extends Node


@export var continue_button : Button


func enter_state(_params:Dictionary) -> void:
	FadeLayer.fade_in()
	if GameDataManager.current_game_data.level_on == "":
		continue_button.disabled = true
	$UIElements/Control/CenterContainer/VBoxContainer/NewGameButton.grab_focus()


func exit_state() -> void:
	pass


func _on_new_game_button_pressed() -> void:
	FadeLayer.fade_out()
	await FadeLayer.fade_complete
	GameDataManager.current_game_data.flags = {}
	Main.app.set_state("gameplay", {
		"start_level": "sewers_1",
		"start_spawnpoint": "start"
	})


func _on_continue_button_pressed() -> void:
	FadeLayer.fade_out()
	await FadeLayer.fade_complete
	Main.app.set_state("gameplay", {
		"start_level": GameDataManager.current_game_data.level_on,
		"start_spawnpoint": GameDataManager.current_game_data.checkpoint_on
	})
	
