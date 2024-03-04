class_name PauseMenu
extends CanvasLayer


signal continue_pressed
signal go_to_main_menu_pressed
signal restart_level_pressed
signal next_level_pressed



func _on_mm_button_pressed() -> void:
	go_to_main_menu_pressed.emit()


func _on_next_button_pressed() -> void:
	next_level_pressed.emit()


func _on_restart_button_pressed() -> void:
	restart_level_pressed.emit()


func _on_continue_button_pressed() -> void:
	continue_pressed.emit()


func _on_visibility_changed() -> void:
	$ProgressStatsContainer/GemsLabel.text = "Gems: %s" % GameDataManager.current_game_data.flags.get("gems_collected", 0)
