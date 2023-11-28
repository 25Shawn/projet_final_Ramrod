extends CharacterBody2D
#Fait par Shawn Dutil

@export var dommage = 10

var BOULE: PackedScene = preload("res://Scene/balle_enemi.tscn")
var detecter = false
var player = null
var attaque = false

func projectile(direction: Vector2):
	if BOULE:
		var boule = BOULE.instantiate()
		get_tree().current_scene.add_child(boule)
		boule.global_position = self.global_position
		var boule_rotation = direction.angle()
		boule.rotation = boule_rotation

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	
	
	move_and_slide()


func _on_attaque_detection_body_entered(body):
	pass # Replace with function body.


func _on_attaque_detection_body_exited(body):
	pass # Replace with function body.
