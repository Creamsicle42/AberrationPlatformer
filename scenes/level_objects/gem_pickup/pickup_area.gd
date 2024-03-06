class_name PickupArea
extends Area2D


func _ready() -> void:
    body_entered.connect(
        (func() :GameplayEventBus.bus.do_pickup.emit()).unbind(1)
    )