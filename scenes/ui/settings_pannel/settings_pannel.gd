class_name SettingsPannel
extends PanelContainer


signal accept_pressed



func _ready() -> void:
	%MusicVolumeSlider.value = GameDataManager.current_game_data.music_volume
	%SFXVolumeSlider.value = GameDataManager.current_game_data.sfx_volume
	%FullscreenButton.button_pressed.visible = OS.has_feature("pc")
	%FullscreenButton.button_pressed = GameDataManager.current_game_data.fullscreen
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), GameDataManager.current_game_data.sfx_volume)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), GameDataManager.current_game_data.music_volume)



func _on_accept_pressed() -> void:
	accept_pressed.emit()


func _on_sfx_volume_slider_value_changed(value:float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), value)
	GameDataManager.current_game_data.sfx_volume = value



func _on_music_volume_slider_value_changed(value:float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), value)
	GameDataManager.current_game_data.music_volume = value


func _on_fullscreen_button_toggled(toggled_on:bool) -> void:
	GameDataManager.current_game_data.fullscreen = toggled_on
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN if GameDataManager.current_game_data.fullscreen else DisplayServer.WINDOW_MODE_WINDOWED)
