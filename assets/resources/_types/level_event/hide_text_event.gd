class_name HideSpeechEvent
extends LevelEvent


func execute(_data : Dictionary) -> void:
    SpeechBubbleContainer.current.hide_text()