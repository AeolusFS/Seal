extends Area2D

signal hit_left

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var spring_anim = get_node("Spring_sprite")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Spring_body_shape_entered(body_id, body, body_shape, area_shape):
	
	emit_signal("hit_left")     # send signal 
	#$CollisionShape2D.set_deferred("disabled", true)   # forbid collision
	


func _on_Spring_body_entered(body):
	if body.name == "Player":
		spring_anim.set_frame(0) 
		spring_anim.play("up")

