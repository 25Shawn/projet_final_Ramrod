extends Node
#Fait par Shawn Dutil



func _on_detection_victoire_body_entered(body):
	if body.is_in_group("joueur_principale"):
		get_tree().change_scene_to_file("res://Scene/victoire.tscn")


func _on_boss_niveau_2__enemi_mort():
	$Niveau2/effet_electricite_disparaitre.hide()
