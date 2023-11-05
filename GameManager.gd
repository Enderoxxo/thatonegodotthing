extends Node

enum GameState {
	Start,
	Play,
	Win,
	Lose
}

var current_game_state = GameState.Start
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	match current_game_state:
		GameState.Start:
			pass
		GameState.Play:
			pass
		GameState.Win:
			print("You Win!!!!")
		GameState.Lose:
			print("You Lose... L")
	pass
