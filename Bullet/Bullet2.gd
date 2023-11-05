extends RigidBody2D

enum bullet_state{
	notshot,
	shot
}


var state

func _ready():
	bullet_ready()


func _process(delta):
	if state == bullet_state.shot && linear_velocity <=Vector2(2,2):
		var t = Timer.new()
		t.set_wait_time(2)
		t.set_one_shot(true)
		self.add_child(t)
		t.start()
		await t.timeout
		var shooting =get_tree().get_nodes_in_group("Enemy")[0]
		shooting.shooting_state = shooting.Shoot_state.reset
		
		queue_free()
	pass
	
func bullet_ready():
	state = bullet_state.notshot
	self.set_freeze_enabled(true)
	
	
	
func lauch_bullet():
	state = bullet_state.shot
	self.set_freeze_enabled(false)
	
