extends Node




func _on_detection_victoire_body_entered(body):
	if body.is_in_group("joueur_principale"):
		get_tree().change_scene_to_file("res://Scene/victoire.tscn")
