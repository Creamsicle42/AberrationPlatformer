class_name CutsceneSlideEvent
extends LevelEvent


@export var cutscene_slide : Texture2D
@export_multiline var cutscene_text : String
@export var slide_show_time : float


func execute(_data : Dictionary) -> void:
    CutsceneSlideLayer.current.show_slide(cutscene_slide, cutscene_text, slide_show_time)
    await CutsceneSlideLayer.current.text_accepted