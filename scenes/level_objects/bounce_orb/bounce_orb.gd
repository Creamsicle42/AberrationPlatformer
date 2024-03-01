class_name BounceOrb
extends Area2D




func use_orb() -> void:
	$CollisionShape2D.set_deferred("disabled", true)
	$Polygon2D.visible = false
	$RefreshTimer.start()



func _on_refresh_timer_timeout() -> void:
	$CollisionShape2D.set_deferred("disabled", false)
	$Polygon2D.visible = true
