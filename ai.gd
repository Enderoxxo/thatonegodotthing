extends Node

enum Shoot_state{
	idle,
	firing,
	bullet_lauched,
	handover_ai,
	reset
}

var shooting_state
var tracer
var gunpos
var centered
var prevshot
var firsttime
var bullet_path
var shooter_pos
var correctshot
# Called when the node enters the scene tree for the first time.
func _ready():
	#shooter_pos = get_tree().get_root().get_node("world").get_node("Shooting").position
	centered = $Gun2.position
	bullet_path = load("res://Bullet/Bullet2.tscn")
	correctshot = $CorrectShot.position
	shooting_state = Shoot_state.firing


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	match shooting_state:
		Shoot_state.firing:
			var bullet = get_tree().get_nodes_in_group("Bullet2")[0]
			
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
			shooting_state = Shoot_state.bullet_lauched
			GameManager.current_game_state = GameManager.GameState.Play
			get_tree().get_nodes_in_group("Camera")[0].follow_bullet = true
			
			
			pass

		Shoot_state.reset:
			var bullet = bullet_path.instantiate()
			bullet.bullet_ready()
			bullet.position.x = 14
			get_node("Gun2").add_child(bullet)
			bullet.visible = false
