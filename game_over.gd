extends Control

@onready var music = $AudioStreamPlayer

@onready var display_tip = $Tips

@onready var timer = $Timer

var tips := [
	"That one was your fault.",
	"Stars won't let you accelerate for a long period of time.",
	"If you see humans, don't kill them.",
	"Dev is tired.",
	"You might find some bugs.",
	"You just performed a speedrunning glitch :O",
	"Boom! Disaster...",
	"Shoutouts to Kopadot.",
	"Snow Ball's name is Disaster.",
	"Monsters speed up if you don't escape from them quickly.",
	"tf happened there",
	"Do not get too big. Do not get too small either.",
	"You can smash trees if you are quickly (and big!)",
	"It's okay to loose speed sometimes.",
	"Every run is personalized :D",
	"Do not spam the jump button, it takes time to prepare...",
	"Just smash the cars",
	"sorry nothing",
	"You and your friends are dead. GAME OVER.",
	"Yep, one life and no continues.",
	"hehe.",
	"Sorry no tips this time",
	"[Funny reference]",
	"Let's try again.",
	"Restarting game...",
	"Video games!",
	"WOW! YOU LOOSE!",
	"There's no 'you win' screen, so technically you didn't lose.",
	"KILL THEM! KILL THEM!",
	"Dark snowballs teleport you.",
	"Restart the game quickly with the 'R' key.",
	"At least the game didn't crash :D",
	"Rocks hurt you I guess (I didn't test the game)",
	"O.O",
	"If you see humans, kill them.",
	"Stop dying."
]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("hola")
	randomize()
	display_tip.text = tips[randi() % tips.size()]
	music.play()
	timer.start(2.0)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://world.tscn")
	print("hola")
	get_tree().paused = false
