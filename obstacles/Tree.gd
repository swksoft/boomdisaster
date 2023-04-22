extends StaticBody2D

@onready var player = get_tree().get_nodes_in_group("Player")[0]
#@onready var player = get_tree().get_root().get_node("player")
#@onready var player = load("res://player/player.tscn")

@onready var animation = $AnimatedSprite2D
@onready var collision = $CollisionShape2D

var ded = false

func _on_area_2d_body_entered(_body: Node2D) -> void:
	if player.velocity.y >= 500 and player.scale >= Vector2(1.50,1.50):
		collision.disabled = true
		queue_free()
		player.scale -= Vector2(0.25,0.25)
	elif player.velocity.y >500 and player.scale < Vector2(1.50,1.50):
		ded = true
		animation.play("ded")
		player.scale -= Vector2(0.25,0.25)
		collision.disabled = true
	else:
		pass
	
	if player.scale <= Vector2(1.50,1.50):
		player.velocity.y /= 1.05
		queue_free()
		
		if player.velocity.y < 400:
			player.scale -= Vector2(0.25,0.25)
