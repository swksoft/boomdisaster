extends CharacterBody2D

var motion = Vector2.ZERO

@export var speed = 1.0

@onready var player = get_tree().get_nodes_in_group("Player")[0]
@onready var hud = get_tree().get_root().get_node("hud")

@onready var timer := $Timer

@onready var game_over := $Game_Over



#var player = preload("res://player/player.tscn").instantiate()
#@onready var player = get_tree().get_root().get_node("player")
#@export var player:PackedScene

#const PLAYER_SCENE = preload("res://player/player.tscn")

#@onready var player := get_tree().get_root().get_node("world").get_node("player")

func follow():
	#var instance = player.instantiate()
	
	#var player = PLAYER_SCENE.instantiate()
	
	#motion = Vector2.ZERO
	position += position.direction_to(player.position) * speed
	move_and_slide()
	#print(player.position, "vs", position)
	#print(speed)
	#print(timer.time_left)

func _physics_process(_delta: float) -> void:
	follow()

func _on_timer_timeout() -> void:
	speed /= 0.5
	if speed >= 64:
		timer.stop()

func _on_area_2d_body_entered(_body: Node2D) -> void:
	hud.mseg = Global.game_data.MINUTES
	hud.seg = Global.game_data.SECONDS
	hud.mi = Global.game_data.MSECONDS
	
	game_over.start(1.0)
	get_tree().paused = true
	$AudioStreamPlayer.play()

func _on_game_over_timeout() -> void:
	get_tree().quit()
	pass
