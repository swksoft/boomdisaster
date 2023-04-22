extends Node2D

var monster = preload("res://monster/monster.tscn")

@onready var player = get_tree().get_nodes_in_group("Player")[0]
@onready var camera = get_tree().get_nodes_in_group("Camera")[0]
@onready var despawn = $despawn
@onready var hud = $HUD

@onready var spawner = $Spawner

func _ready() -> void:
	$BGM.play()
	randomize()

func _process(_delta: float) -> void:
	# 		POSICION DE LA CÁMARA Y OBJETOS EN PANTALLA
	
	despawn.global_position = camera.global_position
	hud.global_position = Vector2(camera.global_position.x-255, camera.global_position.y-400)
	spawner.global_position = Vector2(camera.global_position.x-255, camera.global_position.y+800)
