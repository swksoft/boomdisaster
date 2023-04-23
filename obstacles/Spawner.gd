extends Node2D

const MIN_SPAWN_TIME = 0.1

@onready var camera = get_tree().get_nodes_in_group("Camera")[0]
@onready var player = get_tree().get_nodes_in_group("Player")[0]

var monster = preload("res://monster/monster.tscn")

var preloadedObstacles := [
	preload("res://obstacles/Tree.tscn"),
	preload("res://obstacles/Roca.tscn"),
	preload("res://obstacles/Estrella.tscn"),
	preload("res://obstacles/Car.tscn"),
	preload("res://obstacles/peasant.tscn"),
	preload("res://obstacles/forest.tscn"),
	preload("res://obstacles/long_rock.tscn"),
	preload("res://obstacles/shadow_ball.tscn"),
]

@onready var spawnTimer := $ObstacleSpawn

var nextSpawnTime := 0.2
var nextSpawnTime2 := 0.1

func _ready():
	randomize()
	spawnTimer.start(nextSpawnTime)

func _on_obstacle_spawn_timeout() -> void:
	# Spawn an enemy
	var xPos := randf_range(camera.global_position.x-1500, camera.global_position.x+1500)
	
	if player.velocity.y <= 100:
		pass
	else:
		if randf() < 0.05:
			var monster_spawn = monster.instantiate()
			monster_spawn.position = Vector2(xPos, position.y)
			get_tree().current_scene.add_child(monster_spawn)
		else:
			var obstaclePreload = preloadedObstacles[randi() % preloadedObstacles.size()]
			var obstacle = obstaclePreload.instantiate()
			obstacle.position = Vector2(xPos, position.y)
			get_tree().current_scene.add_child(obstacle)
		
		# Restart the timer
		nextSpawnTime -= 0.01
		if nextSpawnTime < MIN_SPAWN_TIME:
			nextSpawnTime = MIN_SPAWN_TIME
		spawnTimer.start(nextSpawnTime)


func _on_obstacle_spawn_2_timeout() -> void:
	var xPos2 := randf_range(camera.global_position.x-1500, camera.global_position.x+1500)
	
	if player.velocity.y <= 100:
		pass
	else:
		if randf() < 0.5:
			var obstaclePreload2 = preloadedObstacles[5]
			obstaclePreload2.position = Vector2(xPos2, position.y)
			get_tree().current_scene.add_child(obstaclePreload2)
		else:
			var obstaclePreload2 = preloadedObstacles[randi() % preloadedObstacles.size()]
			var obstacle2 = obstaclePreload2.instantiate()
			obstacle2.position = Vector2(xPos2, position.y)
			get_tree().current_scene.add_child(obstacle2)
		
		# Restart the timer
		nextSpawnTime2 -= 0.01
		if nextSpawnTime2 < MIN_SPAWN_TIME:
			nextSpawnTime2 = MIN_SPAWN_TIME
		spawnTimer.start(nextSpawnTime2)
