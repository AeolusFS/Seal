extends KinematicBody2D

var motion = Vector2()
var gravity = 30
var jump = Vector2(0, -1)
var jump_height = -300
var on_wall_speed = 80
var on_wall_l = false
var on_wall_r = false
var bounce_height = 500
var bounce_width = 1600
onready var can_double_jump = 1
onready var player_anim = get_node("Player_sprite")

func _physics_process(delta):
	motion.y += gravity
	
	if Input.is_action_pressed("ui_left"):
		motion.x = -200
	elif Input.is_action_pressed("ui_right"):
		motion.x = 200
	else:
		motion.x = 0
		
	if is_on_floor():
		can_double_jump = 1
		if Input.is_action_just_pressed("ui_up"):
			motion.y = jump_height
	else:
		if Input.is_action_just_pressed("ui_up") and can_double_jump == 1:
			motion.y = jump_height
			can_double_jump = 0
		else:
			motion.y = min(motion.y + gravity, MAX_gravity)

	move_and_slide(motion*delta*70, jump)
	
	if on_wall_l:
		if motion.x > -200:
			motion.x -= 200
		if motion.x < -200:
			on_wall_l = false
	
	if on_wall_r:
		if motion.x < 200:
			motion.x += 200
		if motion.x > 200:
			on_wall_r = false
			

func _on_BSpring_hit_up():
	motion.y = -bounce_height

func _on_USpring_hit_down():
	motion.y = bounce_height

func _on_LSpring_hit_left():
	motion.x -= bounce_width
	motion.y = -bounce_height

func _on_RSpring_hit_right():
	motion.x += bounce_width
	motion.y = -bounce_height

	move_and_slide(motion, jump)
