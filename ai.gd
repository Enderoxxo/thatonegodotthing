extends Node

enum AIShoot_state{
	idle,
	firing,
	bullet_lauched,
	handover_ai,
	reset
}

var AIshooting_state
var tip_of_gun
var gun2pos
var centered
var ai_turn
@onready var shooting = get_tree().get_nodes_in_group("Shooting")[0]
var bullet_path
var shooter_pos
var correctshot
# Called when the node enters the scene tree for the first time.
func _ready():
	#shooter_pos = get_tree().get_root().get_node("world").get_node("Shooting").position
	centered = $Gun2.position
	bullet_path = load("res://Bullet/Bullet2.tscn")
	correctshot = $CorrectShot.position
	AIshooting_state = AIShoot_state.firing
	tip_of_gun = get_tree().get_nodes_in_group("Tipofgun")[0].position
	gun2pos = $Gun2


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	var t = Timer.new()
	t.set_wait_time(2)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	await t.timeout
	match AIshooting_state:
		AIShoot_state.firing:
			var bullet = get_tree().get_nodes_in_group("Bullet2")[0]
			gun2pos.look_at(correctshot)
			var location = correctshot
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
			AIshooting_state = AIShoot_state.bullet_lauched
			#GameManager.current_game_state = GameManager.GameState.Play
			get_tree().get_nodes_in_group("Camera")[0].AIfollow_bullet = true
			
			
			pass

		AIShoot_state.reset:
			var bullet = bullet_path.instantiate()
			bullet.bullet_ready()
			bullet.position = tip_of_gun
			get_node("Gun2").add_child(bullet)
			bullet.visible = false

			shooting.shooting_state = shooting.Shoot_state.idle
				
