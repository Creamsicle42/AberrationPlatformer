extends Node


@export var foostep_player : AudioStreamPlayer
@export var animation_player : AnimatedSprite2D


var footstep_anim := "run"
var footstep_frames := [1, 4]


func _on_main_sprite_frame_changed() -> void:
    if not animation_player.animation == footstep_anim: return
    if not animation_player.frame in footstep_frames: return
    do_footstep()

func do_footstep() -> void:
    foostep_player.play()


func _on_platformer_behavior_landed() -> void:
    do_footstep()

func _on_platformer_behavior_jumped() -> void:
    do_footstep()
