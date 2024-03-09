class_name EventExecutor
extends Node


@export var events : Array[LevelEvent]


func execute() -> void:
    var data : Dictionary = {
        "caller": self
    }
    for event : LevelEvent in events: await event.execute(data)