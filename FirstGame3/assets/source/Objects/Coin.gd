extends Area2D

onready var animation: AnimationPlayer = get_node("AnimationPlayer") # Calling the callback,
#but whitout call a function -> animation -> reference of AnimationPlayer
func _onready():
	animation.play("Bouncing")


func _on_Coin_body_entered(body: Node):
	if body is Player:
		animation.play("Fade")
