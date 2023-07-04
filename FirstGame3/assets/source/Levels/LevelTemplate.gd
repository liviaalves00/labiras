extends Node2D

func _on_KillArea_body_entered(body):
	if body is Actor:
		body.death()
