extends Area2D

signal hit

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass



func _on_Spring_body_shape_entered(body_id, body, body_shape, area_shape):
	
	emit_signal("hit")     # send signal 
	#$CollisionShape2D.set_deferred("disabled", true)   # forbid collision