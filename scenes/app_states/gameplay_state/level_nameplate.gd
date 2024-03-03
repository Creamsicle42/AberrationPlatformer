extends Label




func _on_level_manager_level_changed(new_level_id:Variant) -> void:
	text = tr("level_name.%s" % new_level_id)
	visible_ratio = 0.0
	var tween = create_tween()
	tween.tween_interval(1.0)
	tween.tween_property(self, "visible_ratio", 1.0, 1.5)
	tween.tween_interval(1.0)
	tween.tween_property(self, "visible_ratio", 0.0, 0.5)