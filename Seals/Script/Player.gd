extends KinematicBody2D

var motion = Vector2()
var gravity = 12
var acceleration = 40
var MAX_speed = 200
var MAX_gravity = 300
var jump = Vector2(0, -1)
var jump_height = -200
var on_wall_speed = 80
var on_wall_l = false
var on_wall_r = false
var bounce_height = 350
onready var can_double_jump = 1
onready var player_anim = get_node("Player_sprite")

onready var red_heart = 0
onready var black_heart = 0
onready var heart_to_go_next = 0

onready var first_level_pos = Vector2(1589, 1327)
onready var second_level_pos = Vector2(337, 2350)
onready var third_level_pos = Vector2(293, 3172)
onready var forth_level_pos = Vector2(2666, 1818)

onready var tem_start_pos = Vector2(1564, -580)

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
		can_double_jump = 1
		if Input.is_action_just_pressed("ui_up"):
			if Input.is_action_pressed("ui_left"):
				motion.x = max(motion.x - acceleration, -MAX_speed)
			if Input.is_action_pressed("ui_right"):
				motion.x = min(motion.x + acceleration, MAX_speed)
			motion.y = jump_height
	else:
		if Input.is_action_just_pressed("ui_up") and can_double_jump == 1:
			motion.y = jump_height
			can_double_jump = 0
		motion.y = min(motion.y + gravity, MAX_gravity)


	move_and_slide(motion*delta*70, jump)
	
	if on_wall_l:
		if motion.x > -150:
			motion.x -= 150
		if motion.x < -150:
			on_wall_l = false
	
	if on_wall_r:
		if motion.x < 150:
			motion.x += 150
		if motion.x > 150:
			on_wall_r = false
			
	var collision = move_and_collide(motion * delta)
	if collision:
		
		if collision.collider.get_name() == "first_book" and heart_to_go_next == 1:
			tem_start_pos = first_level_pos
			self.position = first_level_pos
		elif collision.collider.get_name() == "second_book" and heart_to_go_next == 2:
			tem_start_pos = second_level_pos
			self.position = second_level_pos
		elif collision.collider.get_name() == "third_book" and heart_to_go_next == 3:
			tem_start_pos = third_level_pos
			self.position = third_level_pos
		elif collision.collider.get_name() == "forth_book" and heart_to_go_next == 4:
			tem_start_pos = forth_level_pos
			self.position = forth_level_pos
			
		elif collision.collider.get_name() == "Red_heart_lv1":
			red_heart += 1
			get_node("/root/World/Outer/Red_heart_lv1").queue_free()
			heart_to_go_next = max(1, heart_to_go_next)
		elif collision.collider.get_name() == "Black_heart_lv1":
			black_heart += 1
			get_node("/root/World/Inner/Black_heart_lv1").queue_free()
			heart_to_go_next = max(1, heart_to_go_next)
		elif collision.collider.get_name() == "Red_heart_lv2":
			red_heart += 1
			get_node("/root/World/Inner/Red_heart_lv2").queue_free()
			heart_to_go_next = max(2, heart_to_go_next)
		elif collision.collider.get_name() == "Black_heart_lv2":
			black_heart += 1
			get_node("/root/World/Inner/Black_heart_lv2").queue_free()
			heart_to_go_next = max(2, heart_to_go_next)
		elif collision.collider.get_name() == "Red_heart_lv3":
			red_heart += 1
			get_node("/root/World/Inner/Red_heart_lv3").queue_free()
			heart_to_go_next = max(3, heart_to_go_next)
		elif collision.collider.get_name() == "Black_heart_lv3":
			black_heart += 1
			get_node("/root/World/Inner/Black_heart_lv3").queue_free()
			heart_to_go_next = max(3, heart_to_go_next)
		elif collision.collider.get_name() == "Red_heart_lv4":
			red_heart += 1
			get_node("/root/World/Inner/Red_heart_lv4").queue_free()
			heart_to_go_next = max(4, heart_to_go_next)
		elif collision.collider.get_name() == "Black_heart_lv4":
			black_heart += 1
			get_node("/root/World/Inner/Black_heart_lv4").queue_free()
			heart_to_go_next = max(4, heart_to_go_next)
			
			
			
		elif collision.collider.get_name() == "OuterCier" or collision.collider.get_name() == "InnerCier":
			self.position = tem_start_pos
			

func _on_BSpring_hit_up():
	motion.y = -bounce_height

func _on_USpring_hit_down():
	motion.y = bounce_height


