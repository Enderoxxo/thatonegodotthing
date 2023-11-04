extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("Left_Mouse"):
		var distance = get_global_mouse_position()
		if distance.distance_to($CenterOfPlayer.position) > 100:
			distance = (distance - $CenterOfPlayer.position).normalize * 100 + $CenterOfPlayer.position
			
		
	else:
		var location = get_global_mouse_position()
		var distance = location.distance_to($CenterOfPlayer.position)
		var velocity = $CenterOfPlayer - location
		var bullet = get_tree().get_nodes_in_group("bullet")[0]
		bullet = bullet as RigidBody2D
		bullet.apply_impulse(Vector2(), velocity)
