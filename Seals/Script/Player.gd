extends KinematicBody2D

var motion = Vector2()
var gravity = 30
var jump = Vector2(0, -1)
var jump_height = -700

func _physics_process(delta):
	motion.y += gravity
	
	if Input.is_action_pressed("ui_left"):
		motion.x = -200
	elif Input.is_action_pressed("ui_right"):
		motion.x = 200
	else:
		motion.x = 0
		
	if is_on_floor():
		if Input.is_action_pressed("ui_up"):
			motion.y = jump_height

	move_and_slide(motion, jump)
