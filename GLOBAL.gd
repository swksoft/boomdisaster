extends Node

const MAX_SIZE = Vector2(5.0,5.0)
const MIN_SIZE = Vector2(0.25,0.25)

@onready var puntaje = 0
@onready var rng : RandomNumberGenerator = RandomNumberGenerator.new()
var scale = Vector2.ZERO

func game_over_check(scale):
	if scale <= MIN_SIZE:
		Global.game_over_screen()
		#get_tree().change_scene_to_file("res://game_over.tscn")

func grow_up(scale):
	scale += MIN_SIZE#Vector2(0.25, 0.25)
	game_over_check(scale)
	return scale

func shrink_down(scale):
	scale -= MIN_SIZE
	game_over_check(scale)
	return scale

func game_over_screen():
	get_tree().change_scene_to_file("res://game_over.tscn")

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
