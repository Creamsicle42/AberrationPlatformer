extends Node


var current_track : AudioStreamPlayer


func fade_into_track(track : AudioStream, time := 0.5) -> void:
    if current_track:
        var current_tweener = create_tween()
        current_tweener.tween_property(current_track, "volume_db", -80, time)
        current_tweener.tween_callback(current_track.queue_free)
    
    var new_track = AudioStreamPlayer.new()
    new_track.stream = track
    new_track.volume_db = -80
    
    add_child(new_track)
    current_track = new_track
    current_track.play()
    current_track.bus = "Music"
    var new_tweener = create_tween()
    new_tweener.tween_property(current_track, "volume_db", 0, time)
