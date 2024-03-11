class_name SlideVisibleEvent
extends LevelEvent


@export var slow := true
@export var visible := true


func execute(_data : Dictionary) -> void:
    if slow:
        if visible:
            CutsceneSlideLayer.current.fade_appear()
        else:
            CutsceneSlideLayer.current.fade_hide()
        await CutsceneSlideLayer.current.fade_complete
    else:
        if visible:
            CutsceneSlideLayer.current.quick_appear()
        else:
            CutsceneSlideLayer.current.quick_hide()
