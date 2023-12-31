extends Node2D

enum Shoot_state{
	idle,
	firing,
	bullet_lauched,
	handover_ai,
	reset
}

var tip_of_gun
var shooting_state
var tracer
var gunpos
var centered
var prevshot
var firsttime
var bullet_path
@onready var Enemy = get_tree().get_nodes_in_group("Enemy")[0]
# Called when the node enters the scene tree for the first time.
func _ready():
	shooting_state = Shoot_state.idle
	tracer = $tracer
	gunpos = $Gun
	centered = $center_of_gun.position
	prevshot = $prevshot
	firsttime = true
	bullet_path = load("res://Bullet/Bullet.tscn")
	tip_of_gun = get_tree().get_nodes_in_group("tipofgun")[0].position
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	match shooting_state:
		Shoot_state.idle:
			pass
		Shoot_state.firing:
			var bullet = get_tree().get_nodes_in_group("Bullet")[0]
			if firsttime != true:
				prevshot.visible = true
				
			if Input.is_action_pressed("Left_Mouse"):
				tracer.visible = true

				var mousepos = get_global_mouse_position()
				
				

				if mousepos.distance_to(centered) > 100:
					mousepos = (mousepos - centered).normalized() * 100 + centered
					
				tracer.points[1] = mousepos
				gunpos.look_at(mousepos)

				
				
			else:
				var location = get_global_mouse_position()
				var distance = location.distance_to(centered)
				var velocity = centered - location
				bullet.lauch_bullet()
				bullet.visible = true
				print(distance)
				print(velocity)
				bullet = bullet as RigidBody2D
				if velocity.x <-100:
					velocity.x = -100
					distance = 100
					
				elif velocity.x > 100:
					velocity.x = 100
					distance = 100
					
				#if velocity
				print(velocity)
				bullet.apply_impulse(-velocity/5 * distance)
				shooting_state = Shoot_state.bullet_lauched
				GameManager.current_game_state = GameManager.GameState.Play
				get_tree().get_nodes_in_group("Camera")[0].follow_bullet = true
				
				if firsttime == true:
					firsttime = false

		Shoot_state.bullet_lauched:
			pass
			
		Shoot_state.handover_ai:
			Enemy.ai_turn = true
			#Enemy.AIshooting_state = Enemy.AIShoot_state.firing
			pass
			
		Shoot_state.reset:
			var bullet2 = bullet_path.instantiate()
			bullet2.bullet_ready()
			bullet2.position = tip_of_gun
			get_node("Gun").add_child(bullet2)
			bullet2.visible = false

			shooting_state = Shoot_state.handover_ai
			
	pass


func _on_touch_area_input_event(viewport, event, shape_idx):
	if shooting_state == Shoot_state.idle:
		if(event is InputEventMouseButton && event.pressed):
			shooting_state = Shoot_state.firing
			prevshot.points[1] = tracer.points[1]
	pass # Replace with function body.
