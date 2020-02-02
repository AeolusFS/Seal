extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var Outer = true
onready var inner_tile = $Inner
onready var outer_tile = $Outer
onready var initial_pos = Vector2(256, 200)

var glow_power = 0.2
var shot_trans = false

func _ready():
	remove_child($Outer)
	remove_child($Inner)
	add_child(outer_tile)
	move_child(get_node("Glow_shader"), get_child_count())
	

func _input(event):
	if event.is_action_pressed("Key_Z"):
		shot_trans = true
		if (Outer):
			add_child(inner_tile)
			remove_child(outer_tile)
			inner_tile.show()
			Outer = false
		else:
			add_child(outer_tile)
			remove_child(inner_tile)
			outer_tile.show()
			Outer = true
		move_child(get_node("Glow_shader"),  get_child_count())
			
	if event.is_action_pressed("Key_R"):
		$Player.position = initial_pos


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if shot_trans:
		if glow_power <= 0.5:
			glow_power += 0.1
		else:
			shot_trans = false
	if glow_power >= 0.2 and !shot_trans:
		glow_power -= 0.2
	if glow_power <= 0.2:
		glow_power = 0.2
	
	get_node("/root/World/Player/Camera2D/Glow_shader").get_material().set_shader_param("glow", glow_power)
	
#	pass


func _on_Spring_body_entered(body):
	pass # Replace with function body.
