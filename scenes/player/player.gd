class_name Player
extends CharacterBody2D


static var player : Player


@export var velocity_wind_noise : Curve
@export var gravity_change_particles : PackedScene

var dying := false
var wind_vol := 0.0

func _ready() -> void:
	player = self
	await get_tree().process_frame
	GameCamera.camera.track_node = self


func _process(delta: float) -> void:
	$FlipPivot.scale.y = sign($GravityManager.get_gravity_direction().y)
	wind_vol = lerp(wind_vol, velocity.length() / 1000.0, 5.0 * delta)
	%Wind.volume_db = velocity_wind_noise.sample(wind_vol)

func get_gravity_manager() -> GravityManager:
	return $GravityManager


func set_controlls_locked(is_locked : bool) -> void:
	$PlatformerBehavior.controll_locked = is_locked


func killed() -> void:
	dying = true
	%Die.play()
	$DeathBehavior.do_death()
	await get_tree().create_timer(0.5).timeout
	GameplayEventBus.bus.player_killed.emit()
	Input.start_joy_vibration(0, 0.8, 0.8, 0.5)
	


func _on_hazard_hitbox_body_entered(_body:Node2D) -> void:
	if dying == true: return
	killed()


func _on_gravity_manager_gravity_changed() -> void:
	if $GravityManager.get_gravity_direction() == Vector2.UP:
		(%GravChange as AudioStreamPlayer).play()
		(AudioServer.get_bus_effect(1,0) as AudioEffectLowPassFilter).cutoff_hz = 200
	else:
		(%GravRevert as AudioStreamPlayer).play()
		(AudioServer.get_bus_effect(1,0) as AudioEffectLowPassFilter).cutoff_hz = 20000
	

	var dust_cloud :CPUParticles2D= gravity_change_particles.instantiate()
	get_parent().add_child(dust_cloud)
	dust_cloud.global_position = global_position
	dust_cloud.emitting = true
	get_tree().create_timer(1.0).timeout.connect(dust_cloud.queue_free)
