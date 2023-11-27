extends CharacterBody2D

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var vie_enemie = 100
var joueur_range = false
var ennemi_vivant = true

func animation():
	if joueur_range:
		$AnimatedSprite2D.play("hurt")
	elif !ennemi_vivant:
		$AnimatedSprite2D.play("death")
		
func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	animation()
	dammage()
	move_and_slide()

func _on_hitox_body_entered(body):
	if body.is_in_group("balle_joueur"):
		joueur_range = true

func _on_hitox_body_exited(body):
	if body.is_in_group("balle_joueur"):
		joueur_range = false

func dammage():
	if joueur_range:
		vie_enemie -= 10
		print(vie_enemie)
		if vie_enemie <= 0:
			ennemi_vivant = false

func _on_animated_sprite_2d_animation_finished():
	var finished_animation = $AnimatedSprite2D.animation
	if finished_animation == "death":
		queue_free()
