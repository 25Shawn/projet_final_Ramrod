extends CharacterBody2D

var SPEED = 500

func _physics_process(delta):
	var direction = Vector2.RIGHT.rotated(rotation)
	global_position += SPEED * direction * delta
	
	var collision = move_and_collide(SPEED * direction * delta)

	if collision:
		queue_free()
