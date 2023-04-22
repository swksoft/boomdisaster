extends StaticBody2D

@onready var player = get_tree().get_nodes_in_group("Player")[0]

@onready var debuff = $Timer

func _on_area_2d_body_entered(_body: Node2D) -> void:
	
	var _speed = player.velocity.y
	player.velocity.y = player.velocity.y/2.5
	
	debuff.start(3.0)

func _on_timer_timeout() -> void:
	var _speed = player.velocity.y
