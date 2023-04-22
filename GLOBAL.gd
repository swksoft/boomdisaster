extends Node

@onready var puntaje = 0

@onready var rng : RandomNumberGenerator = RandomNumberGenerator.new()

func randomificar(min_num, max_num):
	rng.randomize()
	var random = rng.randf_range(min_num, max_num)
	return random

const SAVEFILE = "user://PICOSAVE.save"

var game_data = {
	"MINUTES" : 0,
	"SECONDS" : 0,
	"MSECONDS" : 0
}

func _ready():
	load_data()
	
func load_data():
	var file = FileAccess.open(SAVEFILE,FileAccess.READ)
	print(file)
	if file == null:
		save_data()
	else:
		game_data = file.get_var()
		file = null

func save_data():
	var file = FileAccess.open(SAVEFILE,FileAccess.WRITE)
	file.store_var(game_data)
	file = null
