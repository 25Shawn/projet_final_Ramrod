extends CharacterBody2D


var BOULE: PackedScene = preload("res://Scene/balle_enemi.tscn")

func projectile(direction: Vector2):
	if BOULE:
		var boule = BOULE.instantiate()
		get_tree().current_scene.add_child(boule)
		boule.global_position = self.global_position
		var boule_rotation = direction.angle()
		boule.rotation = boule_rotation
