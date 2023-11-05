extends Camera2D


var startingpos
var bullet
var follow_bullet
var tween
# defining what each variable is for 
func _ready():
	startingpos	 = global_position
	bullet = get_tree().get_nodes_in_group("Bullet")[0]

	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if follow_bullet:
		if is_instance_valid(bullet):
			var bulletpos = clamp(bullet.position.x,0,5000)
			self.global_position = bullet.global_position
		else:
			# tweening for the camera to follow the bullet
			follow_bullet = false
			tween = get_tree().create_tween()
			tween.tween_property(self,"position",startingpos,2)
			bullet = get_tree().get_nodes_in_group("Bullet")[0]
	pass
