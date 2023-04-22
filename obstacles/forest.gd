extends StaticBody2D

@onready var player = get_tree().get_nodes_in_group("Player")[0]
#@onready var player = get_tree().get_root().get_node("player")
#@onready var player = load("res://player/player.tscn")

func _on_area_2d_2_body_entered(_body: Node2D) -> void:
	if player.scale >= Vector2(2.0,2.0):
		player.velocity.y /= 2.0
		
		if player.velocity.y < 400:
			player.scale -= Vector2(0.25,0.25)
	
	else:
		var player_anim = player.get_node("AnimatedSprite2D")
		
		player.velocity /= 8
		
		player_anim.stop()
		player_anim.play("damage")
		await player_anim.animation_finished
		player.animation.play("recover")
		await player.animation.animation_finished
