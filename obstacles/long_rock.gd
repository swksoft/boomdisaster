extends StaticBody2D

@onready var player = get_tree().get_nodes_in_group("Player")[0]

func _on_area_2d_body_entered(_body: Node2D) -> void:
	player.velocity.y /= 3
