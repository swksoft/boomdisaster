extends StaticBody2D

@onready var player = get_tree().get_nodes_in_group("Player")[0]

var rng_speed = randf_range(50, 120)

var speed = rng_speed

var direction = randf()

func _ready() -> void:
	randomize()
	$AnimatedSprite2D.play("normal")

func _process(delta: float) -> void:
	if direction < 0.2:
		position.x += speed * delta
		position.y += speed * delta
	elif direction >= 0.21  and direction <= 0.4:
		position.x -= speed * delta
		position.y += speed * delta
	elif direction >= 0.41  and direction <= 0.6:
		position.x += speed * delta
		position.y -= speed * delta
	else:
		position.x -= speed * delta
		position.y -= speed * delta

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		if direction < 0.5:
			player.position.x += 1000
		else:
			player.position.x -= 1000
	
		$AnimatedSprite2D.play("recover")
	
