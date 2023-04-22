extends Camera2D

@onready var player = get_tree().get_nodes_in_group("Player")[0]
#@onready var player = get_tree().get_root().get_node("Player")

func _process(_delta):
	global_position = player.global_position
