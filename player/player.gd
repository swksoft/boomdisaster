extends CharacterBody2D


const SPEED = 240.0
const JUMP_VELOCITY = -400.0
const MAX_SPEED = 1000

var hit : bool

@onready var fullspeed : bool = false
@onready var floor : bool = false

#var position = Vector2.ZERO

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: int = 80 #ProjectSettings.get_setting("physics/2d/default_gravity")

var checkpoint_pos = self.global_position

@onready var animation = $AnimatedSprite2D

func check_maxspeed():
	if velocity.y >= 999:
		velocity.y = MAX_SPEED
		animation.play("fast")

func check_speed():
	if velocity.y >= 400:
		scale = Vector2(1.25, 1.25)
		if velocity.y >= 650: # CAN HIT
			animation.speed_scale = 4
			scale = Vector2(1.5, 1.5)
			if velocity.y >= 850: # CAN HIT 2 TIMES
				animation.speed_scale = 8
				scale = Vector2(2, 2)
	else:
		#fullspeed == false
		animation.speed_scale = 1
		scale = Vector2(1.0, 1.0)
	
func check_hit():
	pass
	#print(hit)
	
func _ready() -> void:
	var anim_faster = false
	var anim_veryfast = false
	
	animation.play("normal")

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta
		animation.play("normal")
		
		check_hit()
		check_maxspeed()
		check_speed()
		
		#if velocity.y >= 500 and velocity.y < 800:
		#	animation.speed_scale = 4
		#elif velocity.y >= 800 and velocity.y < 1150:
		#	animation.speed_scale = 8
		#elif velocity.y >= 1150 and velocity.y < 1600:
		#	animation.stop()
		#	animation.play("fast")
		#elif velocity.y >= 1600:
		#	animation.speed_scale = 4
	
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
	#	velocity.y = JUMP_VELOCITY
	
#	if Input.is_action_just_pressed("ui_down") and !is_on_floor():
#		velocity.y += 100
		
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func _process(_delta: float) -> void:
	#print("Velocidad -> ", (velocity.y+ (gravity*delta) ))
	#print("Metros -> ",Vector2(get_global_position()).y)
	#print(position)
	pass
