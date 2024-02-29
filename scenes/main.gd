class_name Main
extends Node


const STATE_PATHS := {
    "gameplay": "res://scenes/app_states/gameplay_state/gameplay_app_state.tscn"
}


static var app : Main
var current_app_state : Node


func _ready() -> void:
    app = self
    set_state("gameplay")


func set_state(state_id : String, params : Dictionary = {}) -> void:
    assert(STATE_PATHS.has(state_id), "State with id \"%s\" does not exist." % state_id)
    _set_state_deferred.call_deferred(state_id, params)


func _set_state_deferred(state_id : String, params : Dictionary = {}) -> void:
    if current_app_state:
        if current_app_state.has_method("exit_state"): 
            await current_app_state.exit_state()
            current_app_state.queue_free()
            current_app_state = null
    
    var new_state_scene :PackedScene= load(STATE_PATHS[state_id]) as PackedScene

    current_app_state = new_state_scene.instantiate()
    add_child(current_app_state)
    if current_app_state.has_method("enter_state"):
        current_app_state.enter_state(params)
