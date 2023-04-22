extends Node2D

func _ready():
	$AnimatedSprite2D.play()
	$AudioStreamPlayer2D.play()

func _on_audio_stream_player_2d_finished() -> void:
	queue_free()
