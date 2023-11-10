extends CharacterBody2D


@export var speed = 300

func get_input():
	look_at(get_global_mouse_position())
	
func _physics_process(delta):
	get_input()
	move_and_slide()
