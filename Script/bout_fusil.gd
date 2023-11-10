extends CharacterBody2D

const BOULE: PackedScene = preload("res://Scene/balle.tscn")

func _ready():
	$fire_effet.hide()

func projectile(direction: Vector2):
	if BOULE:
		var boule = BOULE.instantiate()
		get_tree().current_scene.add_child(boule)
		boule.global_position = self.global_position
		var boule_rotation = direction.angle()
		boule.rotation = boule_rotation
		
		$Timer_boule.start()

func _physics_process(delta):
	
	if Input.is_action_just_pressed("attack") and $Timer_boule.is_stopped():
		var direction =  self.global_position.direction_to(get_global_mouse_position())
		projectile(direction)
		$fire_effet.show()
		$fire_effet.play("effet")
		
	move_and_slide()

func _on_fire_effet_animation_finished():
	$fire_effet.hide()


func _on_timer_boule_timeout():
	$Timer_boule.stop()
	$fire_effet.hide()
