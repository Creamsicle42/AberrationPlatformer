class_name GameplayAppState
extends Node


## GameplayAppState, Controlls the gameplay half of the game
##
## Handles level advancing, resetting, and returning to the main menu when needed


@export var level_manager : LevelManager
@export var pause_menu : PauseMenu



var is_game_paused := false


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		set_game_paused(not is_game_paused)



func enter_state(params : Dictionary) -> void:
	MusicController.fade_into_track(load("res://assets/audio/music/lab_theme.ogg"))
	var start_level_index = params.get("start_level", "test_1")
	var start_spawnpoint_index = params.get("start_spawnpoint", "start")
	GameDataManager.current_game_data.level_on = start_level_index
	GameDataManager.current_game_data.checkpoint_on = start_spawnpoint_index
	level_manager.go_to_level(start_level_index, start_spawnpoint_index)
	set_game_paused(false)
	FadeLayer.fade_in()
	GameDataManager.save_game_data()


func exit_state() -> void:
	pass


func send_player_to_level(id: String, spawnpoint: String) -> void:
	GameDataManager.current_game_data.level_on = id
	GameDataManager.current_game_data.checkpoint_on = spawnpoint
	GameDataManager.save_game_data()
	FadeLayer.fade_out()
	await FadeLayer.fade_complete
	level_manager.go_to_level(id, spawnpoint)
	FadeLayer.fade_in()


func player_reached_end_of_game() -> void:
	Main.app.set_state("main_menu")


func set_game_paused(paused : bool) -> void:
	is_game_paused = paused
	pause_menu.visible = paused
	get_tree().paused = paused
	#level_manager.current_level_node.set_deferred("process_mode", Node.PROCESS_MODE_DISABLED if paused else Node.PROCESS_MODE_INHERIT)


func _on_event_bus_player_killed() -> void:
	FadeLayer.fade_out()
	await FadeLayer.fade_complete
	level_manager.reset_level()
	FadeLayer.fade_in()





func _on_pause_menu_restart_level_pressed() -> void:
	FadeLayer.fade_out()
	await FadeLayer.fade_complete
	level_manager.reset_level()
	set_game_paused(false)
	FadeLayer.fade_in()



func _on_pause_menu_go_to_main_menu_pressed() -> void:
	FadeLayer.fade_out()
	await FadeLayer.fade_complete
	Main.app.set_state("main_menu")


func _on_pause_menu_continue_pressed() -> void:
	set_game_paused(false)


func _on_gameplay_event_bus_player_warp_needed(level_id:Variant, spawnpoint:Variant) -> void:
	send_player_to_level(level_id, spawnpoint)
