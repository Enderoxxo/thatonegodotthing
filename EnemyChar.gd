extends Node2D

@onready var health = 9
@onready var bodies
@onready var DAMAGE_TAKEN = 3 # THIS is the number we change to balance damage
var deathnotif = 0

func update_hbar():
	$HBar.value = health
	
func take_damage(damage):
	health -= damage
	update_hbar()

func _on_rigid_body_2d_damage():
	take_damage(DAMAGE_TAKEN)
	pass # Replace with function body.

		
# Called when the node enters the scene tree for the first time.
func _ready():
	update_hbar()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.


func _process(delta):
	
	if health <= 0:
		if deathnotif == 0:
			print("You Killed em!")
			GameManager.current_game_state = GameManager.GameState.Win
			deathnotif = 1
	pass


