extends CharacterBody2D

var gravity: int = 80

# CONSTANTS

const SPEED = 300.0
const SPEED_H_SLOW = 250
const JUMP_VELOCITY = -400.0
const MAX_SPEED = 1000.0
const MIN_SPEED = 250.0
const NORMAL_SPEED = 800.0
const MAX_SIZE = Vector2(4.0,4.0)
const MIN_SIZE = Vector2(0.25,0.25)

# NODES

@onready var animation = $AnimatedSprite2D
@onready var collision = $CollisionShape2D
@onready var duration_jump = $jump/DurationJump
@onready var cooldown_jump = $jump/CooldownJump
@onready var slow_grow = $grow/SlowGrow
@onready var normal_grow = $grow/NormalGrow
@onready var fast_grow = $grow/FastGrow
@onready var reload = $Reload
@onready var jump_sfx = $Jump

# STATE MACHINE

enum States{
	NORMAL,
	FAST,
	SLOW,
	JUMP,
	HURT
}
var current_state = States.NORMAL
var has_jumped = false
var fast_run = false
#var can_move : bool

func check_speed():
	'''
	if velocity.y > 0 and velocity.y < 600:
		normalize_animation()
	elif velocity.y > 600 and velocity.y < 999:
		animation.speed_scale = 4
	elif velocity.y >= 1000:
		if current_state == 0:
			velocity.y = NORMAL_SPEED
		else:
			if velocity.y > NORMAL_SPEED:
				velocity.y -= 1
			
		
	if velocity.y > 1000 and current_state == 1:
		if !fast_run:
			fast_run = true
			animation.play("fast")
	else:
		fast_run = false
		normalize_animation()
	'''
	pass

func normalize_animation():
	animation.speed_scale = 2

func grow_up_rate():
	normal_grow.start(3.5)
	'''
	if current_state == 0:
		slow_grow.start(6.0)
		slow_grow.stop()
		fast_grow.stop()
	elif current_state == 2:
		normal_grow.start(4.0)
		normal_grow.stop()
		fast_grow.stop()
	
	elif current_state == 1:
		fast_grow.start(2.5)
		normal_grow.stop()
		slow_grow.stop()
	else:'''
	pass
	
func horizontal_movement(speed_parameter):
	var direction := Input.get_axis("ui_left", "ui_right")
	
	if direction:
		velocity.x = direction * speed_parameter
	else:
		velocity.x = move_toward(velocity.x, 0, speed_parameter)
	
func input_normal():
	if !has_jumped:
		animation.play("normal")
		#normalize_animation()
	
	# HORIZONTAL MOVEMENT
	horizontal_movement(SPEED)
	
	# ACCELERATION
	if Input.is_action_pressed("ui_down"):
		current_state = States.FAST
		#velocity.y = MIN_SPEED
		velocity.y += 20.0
		#if velocity.y <= 20:
	# JUMP
	elif Input.is_action_just_pressed("ui_accept") and has_jumped == false:
		current_state = States.JUMP
	# SLOW DOWN
	elif Input.is_action_pressed("ui_up"):
		current_state = States.SLOW
	
	elif Input.is_action_pressed("Reload"):
		print(reload.timeout)
	
	#elif Input.is_action_just_pressed("increase_size"):
	#	scale = Global.grow_up(scale)
	#elif Input.is_action_just_pressed("decrease_size"):
	#	scale = Global.shrink_down(scale)

func input_fast():
	if !Input.is_action_pressed("ui_down"):
		current_state = States.NORMAL
	elif Input.is_action_just_pressed("ui_accept") and has_jumped == false:
		current_state = States.JUMP
	else:
		horizontal_movement(MIN_SPEED)
	
func input_slow():
	if !Input.is_action_pressed("ui_up"):
		current_state = States.NORMAL
	elif Input.is_action_just_pressed("ui_accept") and has_jumped == false:
		current_state = States.JUMP
	else:
		horizontal_movement(MIN_SPEED)
		if velocity.y <= MIN_SPEED:
			velocity.y = MIN_SPEED
		else:
			if velocity.y <= 10:
				pass
			else:
				velocity.y -= 10

func input_jump():
	print(current_state)
	
	collision.disabled = true
	has_jumped = true
	
	if collision.disabled == true:
		jump_sfx.play()
		animation.play("jump")
		$AnimatedSprite2D.position.y = -20
		
	duration_jump.start(0.35)
	
	current_state = States.NORMAL
	
	cooldown_jump.start(1.5)

func input_hurt():
	pass

func _physics_process(delta: float) -> void:
	
	if is_on_floor():
	
		match current_state:
			States.NORMAL:
				#if velocity.y >= 300 and velocity.y <= 800:
				#can_move = true
				input_normal()
			States.FAST:
				input_fast()
			States.SLOW:
				input_slow()
			States.JUMP:
				#can_move = false
				input_jump()
			States.HURT:
				input_hurt()
	else:
		match current_state:
			States.NORMAL:
				#if velocity.y >= 300 and velocity.y <= 800:
				#can_move = true
				input_normal()
				
			States.FAST:
				input_fast()
			States.SLOW:
				input_slow()
			States.JUMP:
				#can_move = false
				input_jump()
			States.HURT:
				input_hurt()
		
	move_and_fall(delta)
	check_speed()

func move_and_fall(delta):
	velocity.y += gravity * delta * 2
	move_and_slide()

func _on_duration_jump_timeout() -> void:
	# DETALLES
	$AnimatedSprite2D.position.y = 0
	animation.play("normal")
	#animation.speed_scale = 8
	
	collision.disabled = false
	
	velocity.y -= 20
func _on_cooldown_jump_timeout() -> void:
	has_jumped = false

# TEMPORIZADORES DE CRECIMIENTO 
func _on_slow_grow_timeout() -> void:
	pass
	#grow_up()
func _on_normal_grow_timeout() -> void:
	#Global.grow_up(scale)
	scale = Global.grow_up(scale)
func _on_fast_grow_timeout() -> void:
	#grow_up()
	pass

func _process(_delta: float) -> void:
	
	# DEBUG
	print(current_state)
	print(normal_grow.wait_time)
	#print(slow_grow.wait_time)
	#print(fast_grow.wait_time)
	#print(velocity.y)

func _ready() -> void:
	scale = Vector2(1.0,1.0)
	grow_up_rate()
	#normal_grow.start(3.5)

func _on_reload_timeout() -> void:
	#get_tree().reload_current_scene()
	pass
