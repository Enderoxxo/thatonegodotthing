extends Node2D


func _on_quit_pressed():
	get_tree().quit()


func _on_play_pressed():
	# uncomment out this piece of code if you  want to make the mouse cersor hidden 
	#Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	get_tree().change_scene_to_file("res://world.tscn")
