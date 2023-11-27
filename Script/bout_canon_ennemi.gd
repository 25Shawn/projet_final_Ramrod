extends CharacterBody2D
@export var dommage = 10

var BOULE: PackedScene = preload("res://Scene/balle_enemi.tscn")

func projectile(direction: Vector2):
	if BOULE:
		var boule = BOULE.instantiate()
		get_tree().current_scene.add_child(boule)
		boule.global_position = self.global_position
		var boule_rotation = direction.angle()
		boule.rotation = boule_rotation

func _on_enemi_voiture_body_entered(body):
	if body.is_in_group("joueur_principale"):
		
