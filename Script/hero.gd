extends CharacterBody2D

@export var vie = 100
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
	if tomber:
		$AnimatedSprite2D.play("Falling")
		
	elif sauter and !is_on_floor():
		$AnimatedSprite2D.play("Double_jump")
		
	elif dash and is_on_floor():
		$AnimatedSprite2D.play("Dash")
		$point_rotation.position.x = -15
		$point_rotation.position.y = 1
	elif courir:
		$AnimatedSprite2D.play("Run")
		
		$point_rotation.position.x = -10
		$point_rotation.position.y = 4
		
		if$point_rotation/bras/gun.flip_h and $point_rotation/bras/bras_fusil.flip_h:
			$point_rotation.position.x = 10
			$point_rotation.position.y = 4
			#$point_rotation/bras.rotation = angle
			#$point_rotation/bras/bout_fusil/fire_effet.position.x = -20
			#$point_rotation/bras/bout_fusil.position.x = -10
			
			
			
		elif !$point_rotation/bras/gun.flip_h and !$point_rotation/bras/bras_fusil.flip_h:
			$point_rotation.position.x = -10
			$point_rotation.position.y = 4
			#$point_rotation/bras.rotation = 90
			#$point_rotation/bras/bout_fusil/fire_effet.position.x = 25
			#$point_rotation/bras/bout_fusil.position.x = 10
	elif !courir:
		$AnimatedSprite2D.play("Idle")
		$point_rotation.position.x = -15
		$point_rotation.position.y = 1

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
		$point_rotation/bras/gun.flip_h = true
		$point_rotation/bras/bras_fusil.flip_h = true
		$point_rotation/bras/bout_fusil/fire_effet.flip_h = true
	else:
		$AnimatedSprite2D.flip_h = false
		$point_rotation/bras/gun.flip_h = false
		$point_rotation/bras/bras_fusil.flip_h = false
		$point_rotation/bras/bout_fusil/fire_effet.flip_h = false
func _physics_process(delta):
	
	if not is_on_floor():
		velocity.y += gravity * delta
	
	_mouvement(delta)
	_animation()
	move_and_slide()
	
func _on_timer_timeout():
	dash = false
	SPEED = normal_speed
	courir = false
