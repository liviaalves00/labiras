tool # makes the code run on the editor
extends Area2D

onready var animation: AnimationPlayer = get_node("AnimationPlayer")
# Type of .tscn filess
export var next_scene: PackedScene 
func _get_configuration_warning():
	return "You don't defined the next level!" if not next_scene else ''
	
	
func _on_Portal_body_entered(body):
	if body is Player:
		_teleport()

	
func _teleport() -> void:
	animation.play("Appear")
	yield(animation, "animation_finished") # await the player_animation
	get_tree().change_scene_to(next_scene)
	animation.play("Disappear")


