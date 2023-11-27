extends Area2D

@export var dommage = 5
var vie_joueur = 100
var vieJoueur = false 

func _physics_process(delta):
	if vieJoueur:
		get_tree().change_scene_to_file("res://Scene/game_over.tscn")

func _on_body_entered(body):
	if body.is_in_group("joueur_principale"):
		$Timer.start()


func _on_body_exited(body):
	if body.is_in_group("joueur_principale"):
		vieJoueur = false

func _on_timer_timeout():
	vie_joueur -= dommage
	if vie_joueur <= 0:
		vieJoueur = true
