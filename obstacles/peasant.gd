extends StaticBody2D

var speed = 6

var direction = randf()

func _ready() -> void:
	randomize()
	$AnimatedSprite2D.play("default")
	
func _process(delta: float) -> void:
	if direction > 0.5:
		position.x -= speed * delta
	else:
		position.x += speed * delta

func _on_area_2d_body_entered(_body: Node2D) -> void:
	$AnimatedSprite2D.play("ded")
