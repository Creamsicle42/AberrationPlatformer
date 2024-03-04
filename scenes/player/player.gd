class_name Player
extends CharacterBody2D


static var player : Player


@export var gravity_change_particles : PackedScene


func _ready() -> void:
	player = self
	await get_tree().process_frame
	GameCamera.camera.track_node = self


func _process(delta: float) -> void:
	$FlipPivot.scale.y = sign($GravityManager.get_gravity_direction().y)


func get_gravity_manager() -> GravityManager:
	return $GravityManager


func set_controlls_locked(is_locked : bool) -> void:
	$PlatformerBehavior.controll_locked = is_locked


func killed() -> void:
	print_debug("player killed")
	GameplayEventBus.bus.player_killed.emit()


func _on_hazard_hitbox_body_entered(_body:Node2D) -> void:
	killed()


func _on_gravity_manager_gravity_changed() -> void:
	var dust_cloud :CPUParticles2D= gravity_change_particles.instantiate()
	get_parent().add_child(dust_cloud)
	dust_cloud.global_position = global_position
	dust_cloud.emitting = true
	get_tree().create_timer(1.0).timeout.connect(dust_cloud.queue_free)
