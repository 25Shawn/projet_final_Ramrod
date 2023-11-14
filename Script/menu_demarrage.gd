extends Control



func _on_commencer_pressed():
	get_tree().change_scene_to_file("res://Scene/menu_option.tscn")
	
func _on_quitter_pressed():
	get_tree().quit()
