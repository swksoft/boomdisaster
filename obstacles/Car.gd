extends StaticBody2D

@export var Explosion = PackedScene.new()

@onready var player = get_tree().get_nodes_in_group("Player")[0]

func _on_area_2d_body_entered(_body: Node2D) -> void:
	var explosion = Explosion.instantiate()
	explosion.global_position = $ExplosionSpawn.global_position
	#get_tree().call_group("world", "add_child", explosion)
	get_tree().current_scene.add_child(explosion)
	queue_free()
