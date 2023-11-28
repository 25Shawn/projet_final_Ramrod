extends Control

func _ready():
	$Timer.start()

func _on_timer_timeout():
	get_tree().change_scene_to_file("res://Scene/menu_demarrage.tscn")
