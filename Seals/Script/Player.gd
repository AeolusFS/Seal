extends KinematicBody2D

var motion = Vector2()
var gravity = 12
var acceleration = 40
var MAX_speed = 200
var MAX_gravity = 500
var jump = Vector2(0, -1)
var jump_height = -300
var on_wall_speed = 80
var on_wall_l = false
var on_wall_r = false
onready var player_anim = get_node("Player_sprite")

func _physics_process(delta):
	
	if Input.is_action_pressed("ui_left"):
		player_anim.play("walking")
		player_anim.set_flip_h(true)
		motion.x = max(motion.x - acceleration, -MAX_speed)
	elif Input.is_action_pressed("ui_right"):
		player_anim.play("walking")
		player_anim.set_flip_h(false)
		motion.x = min(motion.x + acceleration, MAX_speed)
	else:
		player_anim.play("idle")
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
		if motion.x > -200:
			motion.x -= 200
		if motion.x < -200:
			on_wall_l = false
	
	if on_wall_r:
		if motion.x < 200:
			motion.x += 200
		if motion.x > 200:
			on_wall_r = false
