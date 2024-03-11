class_name ChangeGameStateEvent
extends LevelEvent


@export var state : String
@export var params : Dictionary


func execute(_data : Dictionary) -> void:
    Main.app.set_state(state, params)