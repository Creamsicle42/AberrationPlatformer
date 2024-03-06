class_name DeathBehavior
extends Node


@export var stop_nodes : Array[Node]
@export var graphics_node : Node2D
@export var death_particles : Array[CPUParticles2D]
@export var enabled : bool = false



func _physics_process(delta: float) -> void:
    if not enabled : return

    owner.velocity -= owner.velocity * delta * 10.0

    graphics_node.scale -= graphics_node.scale * delta 

    owner.move_and_slide()


func do_death() -> void:
    for node : Node in stop_nodes:
        node.set_deferred("process_mode", PROCESS_MODE_DISABLED)
    
    graphics_node.modulate = Color(100.0, 100.0, 100.0)

    for particle : CPUParticles2D in death_particles:
        particle.emitting = true
    
    enabled = true

    graphics_node.scale *= 1.25
    owner.velocity = owner.velocity * -2
