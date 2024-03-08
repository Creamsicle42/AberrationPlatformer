class_name PauseMenu
extends CanvasLayer


signal continue_pressed
signal go_to_main_menu_pressed
signal restart_level_pressed
signal next_level_pressed



func _on_mm_button_pressed() -> void:
	UiAudio.player_click()
	go_to_main_menu_pressed.emit()


func _on_next_button_pressed() -> void:
	UiAudio.player_click()
	next_level_pressed.emit()


func _on_restart_button_pressed() -> void:
	UiAudio.player_click()
	restart_level_pressed.emit()


func _on_continue_button_pressed() -> void:
	UiAudio.player_click()
	continue_pressed.emit()


func _on_visibility_changed() -> void:
	%GemsLabel.text = "x%s" % GameDataManager.current_game_data.flags.get("gems_collected", 0)
	$HBoxContainer/ColorRect2/VBoxContainer/ContinueButton.grab_focus()



func _element_hover() -> void:
	UiAudio.play_hover()

