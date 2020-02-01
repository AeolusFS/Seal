extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var Outer = true
onready var inner_tile = $Inner
onready var outer_tile = $Outer

func _ready():
	remove_child($Outer)
	remove_child($Inner)
	add_child(outer_tile)

func _input(event):
	if event.is_action_pressed("Key_Z"):
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


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
