extends Node3D
@export var speed : float
func _process(delta : float) -> void: 
	if $"../CharacterBody3D" : 
		position = position.move_toward($"../CharacterBody3D".position, delta*speed)
		look_at($"../CharacterBody3D".position)
