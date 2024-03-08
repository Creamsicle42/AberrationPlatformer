class_name SettingsPannel
extends PanelContainer


signal accept_pressed


func _on_accept_pressed() -> void:
	accept_pressed.emit()


func _on_sfx_volume_slider_value_changed(value:float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), value)

func _on_music_volume_slider_value_changed(value:float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), value)
