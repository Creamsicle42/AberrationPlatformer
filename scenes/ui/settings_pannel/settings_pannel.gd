class_name SettingsPannel
extends PanelContainer


signal accept_pressed



func _ready() -> void:
	%MusicVolumeSlider.value = GameDataManager.current_game_data.music_volume
	%SFXVolumeSlider.value = GameDataManager.current_game_data.sfx_volume
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
