extends Node


const GAME_DATA_PATH := "user://game_data.res"


var current_game_data : GameData


func load_game_data() -> void:
    current_game_data = load(GAME_DATA_PATH) if FileAccess.file_exists(GAME_DATA_PATH) else GameData.new()


func save_game_data() -> void:
    ResourceSaver.save(current_game_data, GAME_DATA_PATH)