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
			print(get_tree().current_scene.name)
			if get_tree().current_scene.name == "world":
				if get_tree().current_scene.name == "world2":
					get_tree().change_scene_to_file("res://world3.tscn")
				else:
					get_tree().change_scene_to_file("res://world2.tscn")
			GameManager.current_game_state = GameManager.GameState.Start
		GameState.Lose:
			print("You Lose... L")
			get_tree().change_scene_to_file("res://Lose.tscn")
	pass
