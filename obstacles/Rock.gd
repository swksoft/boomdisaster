extends StaticBody2D

@onready var player = get_tree().get_nodes_in_group("Player")

func _on_area_2d_body_entered(_body: Node2D) -> void:
	pass
	#hacer daño
