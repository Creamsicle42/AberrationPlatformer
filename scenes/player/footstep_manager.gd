extends Node


@export var foostep_player : AudioStreamPlayer
@export var animation_player : AnimatedSprite2D
@export var gravity_manager : GravityManager
@export var sounds : Dictionary


var footstep_anim := "run"
var footstep_frames := [1, 4]


func _on_main_sprite_frame_changed() -> void:
    if not animation_player.animation == footstep_anim: return
    if not animation_player.frame in footstep_frames: return
    do_footstep()

func do_footstep() -> void:
    var world_tilemap : TileMap = get_tree().get_first_node_in_group("world_tilemap") as TileMap

    var stream : AudioStream = sounds["stone"]

    var foot_pos = owner.global_position + (gravity_manager.get_gravity_direction() * 12.0)

    var grid_foot_pos = world_tilemap.local_to_map(foot_pos)

    var foot_pos_data := world_tilemap.get_cell_tile_data(2, grid_foot_pos)

    if foot_pos_data != null:

        var sound_id = foot_pos_data.get_custom_data("footstep_sound")

        stream = sounds.get(sound_id, stream)

    foostep_player.stream = stream
    foostep_player.play()


func _on_platformer_behavior_landed() -> void:
    do_footstep()

func _on_platformer_behavior_jumped() -> void:
    do_footstep()
