extends CharacterBody2D
#Fait par Shawn Dutil

@export var dommage = 10

var BOULE: PackedScene = preload("res://Scene/balle_enemi.tscn")
var detecter = false
var player = null

func projectile(direction: Vector2):
	if BOULE:
		var boule = BOULE.instantiate()
		get_tree().current_scene.add_child(boule)
		boule.global_position = self.global_position
		var boule_rotation = direction.angle()
		boule.rotation = boule_rotation

func _on_detection_attaque_body_entered(body):
	if body.is_in_group("joueur_principale"):
		detecter = true
		player = body
		$Timer.start()
		
		
func _on_detection_attaque_body_exited(body):
	if body.is_in_group("joueur_principale"):
		detecter = false
		player = null

func _on_timer_timeout():
	if detecter:
		var direction = (player.global_position - self.global_position).normalized()
		projectile(direction)
