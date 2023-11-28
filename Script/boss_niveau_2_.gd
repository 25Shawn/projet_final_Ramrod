extends CharacterBody2D
#Fait par Shawn Dutil

signal enemi_mort
var speed = 100
var chasse = false
var player = null

var attaque = false
var vie_enemie = 100
var joueur_range = false
var ennemi_vivant = true

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
func _ready():
	$AnimatedSprite2D.play("Idle")
	
func animation():
	if ennemi_vivant:
		
			if chasse:
				position += (player.position - position)/speed
				
				if attaque:
					$AnimatedSprite2D.play("attack")
				else:
					$AnimatedSprite2D.play("walk")
				
				
				if (player.position.x - position.x) < 0:
					$AnimatedSprite2D.flip_h = true
					$CollisionShape2D.position.x = 32
					$CollisionShape2D.position.y = 16
					$detection/CollisionShape2D.position.x = 32
					$detection/CollisionShape2D.position.y = 16
					$hitbox/CollisionShape2D.position.x = 32
					$hitbox/CollisionShape2D.position.y = 16
					$attaque_detection/CollisionShape2D.position.x = 32
					$attaque_detection/CollisionShape2D.position.y = 16
					$canon_gauche.position.x = 16
					$canon_gauche.position.y = 3
					$barre_vie_ennemi.position.x = 72
					$barre_vie_ennemi.position.y = -88
				else:
					$AnimatedSprite2D.flip_h = false
					$CollisionShape2D.position.x = -32
					$CollisionShape2D.position.y = 16
					$detection/CollisionShape2D.position.x = -32
					$detection/CollisionShape2D.position.y = 16
					$hitbox/CollisionShape2D.position.x = -32
					$hitbox/CollisionShape2D.position.y = 16
					$attaque_detection/CollisionShape2D.position.x = -32
					$attaque_detection/CollisionShape2D.position.y = 16
					$canon_gauche.position.x = -16
					$canon_gauche.position.y = 3
					$barre_vie_ennemi.position.x = -72
					$barre_vie_ennemi.position.y = -88
			
			elif joueur_range:
				$AnimatedSprite2D.play("hurt")
			#else:
			#	$AnimatedSprite2D.play("Idle")
				
	elif !ennemi_vivant:
		$AnimatedSprite2D.play("death")
		
		
		
func _physics_process(delta):
	$barre_vie_ennemi/remplissement_barre.value = vie_enemie
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		
	animation()
	dammage()
	
	move_and_slide()

func _on_detection_body_entered(body):
	if body.is_in_group("joueur_principale"):
		player = body
		chasse = true

func _on_detection_body_exited(body):
	player = null
	chasse = false

func dammage():
	if joueur_range:
		vie_enemie -= 3

		if vie_enemie <= 0:
			ennemi_vivant = false
			$explosion.show()
			$explosion.play("explosion")

func _on_hitbox_body_entered(body):
	if body.is_in_group("balle_joueur"):
		joueur_range = true

func _on_hitbox_body_exited(body):
	if body.is_in_group("balle_joueur"):
		joueur_range = false

func _on_animated_sprite_2d_animation_finished():
	var finished_animation = $AnimatedSprite2D.animation
	if finished_animation == "death":
		queue_free()
		emit_signal("enemy_died")
		
	

