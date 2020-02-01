extends KinematicBody2D

var motion = Vector2()
var gravity = 20
var jump = Vector2(0, -1)
var jump_height = -700
var on_wall_l = false
var on_wall_r = false

func _physics_process(delta):
	motion.y += gravity
	
	if Input.is_action_pressed("ui_left"):
		if motion.x > -200:
			motion.x -= 200
	elif Input.is_action_pressed("ui_right"):
		if motion.x < 200:
			motion.x += 200
	else:
		motion.x = 0
		
	if is_on_wall():
		if Input.is_action_pressed("ui_up"):
			if Input.is_action_pressed("ui_left"):
				on_wall_r = true
				motion.y = jump_height
			if Input.is_action_pressed("ui_right"):
				on_wall_l = true
				motion.y = jump_height
			
		
			
	if is_on_floor():
		if Input.is_action_pressed("ui_up"):
			motion.y = jump_height

	move_and_slide(motion*delta*70, jump)
	
	if on_wall_l:
		if motion.x > -700:
			motion.x -= 700
		if motion.x <- 700:
			on_wall_l = false
	
	if on_wall_r:
		if motion.x < 700:
			motion.x += 700
		if motion.x > 700:
			on_wall_r = false
