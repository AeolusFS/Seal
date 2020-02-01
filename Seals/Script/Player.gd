extends KinematicBody2D

var motion = Vector2()
var gravity = 20
var acceleration = 50
var MAX_speed = 200
var MAX_gravity = 1000
var jump = Vector2(0, -1)
var jump_height = -700
var on_wall_speed = 100
var on_wall_l = false
var on_wall_r = false

func _physics_process(delta):
	
	if Input.is_action_pressed("ui_left"):
		motion.x = max(motion.x - acceleration, -MAX_speed)
	elif Input.is_action_pressed("ui_right"):
		motion.x = min(motion.x + acceleration, MAX_speed)
	else:
		motion.x = lerp(motion.x, 0, 0.2)
		
	if is_on_wall():
		if Input.is_action_just_pressed("ui_up"):
			if Input.is_action_pressed("ui_left"):
				on_wall_r = true
				motion.y = jump_height
			if Input.is_action_pressed("ui_right"):
				on_wall_l = true
				motion.y = jump_height
		elif Input.is_action_pressed("ui_right") or Input.is_action_pressed("ui_left"):
			motion.y = min(motion.y, on_wall_speed)
			
	if is_on_ceiling():
		motion.y = gravity
			
	if is_on_floor():
		if Input.is_action_just_pressed("ui_up"):
			motion.y = jump_height
	else:
		motion.y = min(motion.y + gravity, MAX_gravity)

	move_and_slide(motion*delta*70, jump)
	
	if on_wall_l:
		if motion.x > -400:
			motion.x -= 400
		if motion.x < -400:
			on_wall_l = false
	
	if on_wall_r:
		if motion.x < 400:
			motion.x += 400
		if motion.x > 400:
			on_wall_r = false
