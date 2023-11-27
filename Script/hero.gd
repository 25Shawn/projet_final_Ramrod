extends CharacterBody2D

signal heatlh()

@export var vie = 100
var valeur

var enemie_range = false
var enemie_cooldown = true
var joueur_vivant = true

const dash_speed = 400.0
var SPEED = 200.0
const normal_speed = 200.0
const JUMP_VELOCITY = -370.0
var compteur_saut = 0
var max_saut = 2
var angle = 180
var dash = false
var sauter = false
var courir = false
var tomber = false
var attack = false

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _animation():
	if !joueur_vivant:
		$AnimatedSprite2D.play("death")
		$point_rotation_droite.hide()
		
	elif enemie_range:
		$AnimatedSprite2D.play("hurt")
		$point_rotation_droite.hide()
	elif tomber:
		$AnimatedSprite2D.play("Falling")
	elif sauter and !is_on_floor():
		$AnimatedSprite2D.play("Double_jump")
		
	elif dash and is_on_floor():
		$AnimatedSprite2D.play("Dash")
		$point_rotation_droite.position.x = -15
		$point_rotation_droite.position.y = 1
	elif courir:
		$AnimatedSprite2D.play("Run")
	elif !courir:
		$AnimatedSprite2D.play("Idle")
		$point_rotation_droite.position.x = -15
		$point_rotation_droite.position.y = 1

func _dash():
	if dash:
		SPEED = dash_speed
		$Timer.start()

func _mouvement(delta):
	var direction = Input.get_axis("gauche", "droite")
	var direction_sauter = Input.is_action_just_pressed("haut")
	var attaque = Input.is_action_pressed("attack")
	
	if attaque:
		attack = true
	else:
		attack = false


	if Input.is_action_just_pressed("dash"):
		dash = true
		_dash()
	if velocity.y > 350.0 and !is_on_floor():
		tomber = true
		sauter = false
	else:
		tomber = false
		courir = false
	#sauter / double saut
	if is_on_floor():
		compteur_saut = 0
	
	if compteur_saut < max_saut:
		if direction_sauter:
			velocity.y = JUMP_VELOCITY
			sauter = true
			compteur_saut += 1
	
	#bouger gauche ou droite
	if direction:
		velocity.x = direction * SPEED
		courir = true
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		courir = false
		
	if velocity.x < 0 && courir:
		$AnimatedSprite2D.flip_h = true
		#position des collisions
		$Area2D/CollisionShape2D.position.x = 8
		$Area2D/CollisionShape2D.position.y = 8
		$CollisionShape2D.position.x = 8
		$CollisionShape2D.position.y = 8
		# position du fusil
		$point_rotation_droite.position.x = 10
		$point_rotation_droite.position.y = 4
		$point_rotation_droite/bras.position.x = 10
		$point_rotation_droite/bras.position.y = -4
		$point_rotation_droite/bras.rotation_degrees = 180
		$point_rotation_droite/bras.scale.x = abs($point_rotation_droite/bras.scale.x) * -1
	else:
		$AnimatedSprite2D.flip_h = false
		#position des collisions
		$Area2D/CollisionShape2D.position.x = -8
		$Area2D/CollisionShape2D.position.y = 8
		$CollisionShape2D.position.x = -8
		$CollisionShape2D.position.y = 8
		# position du fusil
		$point_rotation_droite.position.x = -10
		$point_rotation_droite.position.y = 4
		$point_rotation_droite/bras.position.x = 12
		$point_rotation_droite/bras.position.y = 4
		$point_rotation_droite/bras.rotation_degrees = 0
		$point_rotation_droite/bras.scale.x = abs($point_rotation_droite/bras.scale.x)


func _get_health() -> int:
	return vie

func _on_heatlh():
	var valeur = _get_health()
	return valeur

func _ready():
	#$Control.hide()
	pass
	
func _physics_process(delta):
	emit_signal("heatlh")
	enemie_attaque()
	
	if vie <= 0:
		joueur_vivant = false
		vie = 0
		
	if not is_on_floor():
		velocity.y += gravity * delta
	
	_mouvement(delta)
	_animation()
	move_and_slide()
	
func _on_timer_timeout():
	dash = false
	SPEED = normal_speed
	courir = false

func player():
	pass

func _on_area_2d_body_entered(body):
	if body.is_in_group("enemies"):
		enemie_range = true
	elif body.is_in_group("balle_enemie"):
		enemie_range = true
		body.queue_free()
	elif body.is_in_group("ennemi"):
		print("bye")

func _on_area_2d_body_exited(body):
	if body.is_in_group("enemies"):
		enemie_range = false
		$point_rotation_droite.show()
		

func enemie_attaque():
	if enemie_range and enemie_cooldown:
		vie -= 10
		enemie_cooldown = false
		$attaque_cooldown.start()
		print(vie)

func _on_attaque_cooldown_timeout():
	enemie_cooldown = true
	
func _on_animated_sprite_2d_animation_finished():
	var finished_animation = $AnimatedSprite2D.animation
	if finished_animation == "death":
		get_tree().change_scene_to_file("res://Scene/game_over.tscn")
