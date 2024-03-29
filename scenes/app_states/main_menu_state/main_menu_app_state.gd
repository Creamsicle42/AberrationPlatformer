class_name MainMenuAppState
extends Node


@export var continue_button : Button


func enter_state(_params:Dictionary) -> void:
	FadeLayer.fade_in()
	if GameDataManager.current_game_data.level_on == "":
		continue_button.disabled = true
	if not OS.has_feature("pc"):
		%QuitButton.visible = false
	%NewGameButton.grab_focus()


	MusicController.fade_into_track(load("res://assets/audio/music/main_menu_loop.ogg"))


func exit_state() -> void:
	pass


func _on_new_game_button_pressed() -> void:
	UiAudio.player_click()
	FadeLayer.fade_out()
	await FadeLayer.fade_complete
	GameDataManager.current_game_data.flags = {}
	Main.app.set_state("gameplay", {
		"start_level": "intro",
		"start_spawnpoint": "start"
	})


func _on_continue_button_pressed() -> void:
	UiAudio.player_click()
	FadeLayer.fade_out()
	await FadeLayer.fade_complete
	Main.app.set_state("gameplay", {
		"start_level": GameDataManager.current_game_data.level_on,
		"start_spawnpoint": GameDataManager.current_game_data.checkpoint_on
	})
	



func _element_hover() -> void:
	UiAudio.play_hover()




func _on_settings_pannel_accept_pressed() -> void:
	%SettingsOwner.visible = false
	%NewGameButton.grab_focus()
	UiAudio.player_click()
	GameDataManager.save_game_data()

func _on_settings_button_pressed() -> void:
	%SettingsOwner.visible = true
	UiAudio.player_click()


func _on_quit_button_pressed() -> void:
	get_tree().quit()
