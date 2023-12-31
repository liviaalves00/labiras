tool
extends Area2D

onready var anim_player: AnimationPlayer = get_node("AnimationPlayer")

export var next_scene: PackedScene

func _on_Portal2D_body_entered(body):
	body.global_position = $Portal.global_position
	body.set_physics_process(false)
	teleport()

func _get_configuration_warning() -> String:
	return "A proxima cena nao pode estar vazia" if not next_scene else " "
	
func teleport() -> void:
	anim_player.play("fade_in")
	yield(anim_player, "animation_finished")
	get_tree().change_scene_to(next_scene)
	

