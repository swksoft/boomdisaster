extends Control

var timer = 0
var timer_on = false

var best_min = 0
var best_seg = 0
var best_mseg = 0

@onready var time = $CanvasLayer/VBoxContainer/HBoxContainer/Time
@onready var best_time = $CanvasLayer/VBoxContainer/HBoxContainer/Best_Time
@onready var dist = $CanvasLayer/VBoxContainer/Distance

@onready var player = get_tree().get_nodes_in_group("Player")[0]

func _ready() -> void:
	timer_on = true

func _process(delta: float) -> void:
	if(timer_on):
		timer += delta
	
	var mseg = fmod (timer, 1) * 1000
	var seg = fmod(timer, 60)
	var mi = fmod(timer, 60 * 60) / 60
	
	var time_passed = "%02d:%02d:%03d" % [mi, seg, mseg]
	
	time.text = "Time: " + time_passed + " " #"Time: 00:00.00 (Max: 16:07.07)"
	
	if mseg >= best_mseg and seg >= best_seg and mi >= best_min:
		mseg = Global.game_data.MINUTES
		seg = Global.game_data.SECONDS
		mi = Global.game_data.MSECONDS
	
	#var best_time_passed = "%02:%02d:%03d" % [best_min, best_seg, best_mseg]
	#best_time.text = "(Max: " + best_time_passed + ")"
	
	if player:
		var dist_passed = "%04d" % [player.get_global_position().y]
	
		dist.text = "Distance -" + dist_passed +" m"
		
	#time.text = "Time: %02d:%02d (Max: 16:07.07)" % [min, seg, best_min, best_seg]
	#var time_passed = "Time: %02d:%02d (Max: 16:07.07)" % [min, seg] #best_min, best_seg]
	
	#var unix_time: float = Time.get_unix_time_from_system()
	#var unix_time_int: int = unix_time
	#var dt: Dictionary = Time.get_datetime_dict_from_unix_time(unix_time)
	#var ms: int = (unix_time - unix_time_int) * 1000.0
	#var str := "%s.%s.%s %s:%s:%s:%s" % [dt.year, dt.month, dt.day, dt.hour, dt.minute, dt.second, ms]
	#print(str)
