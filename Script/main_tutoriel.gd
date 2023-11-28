extends Node

func _ready():
	$fin_tuto.visible = false
	$instruction_4.visible = false

func _process(delta):
	var ennemi_robot = $ennemi_robot_
	

	if !is_instance_valid(ennemi_robot):
		$instruction_4.visible = true
		$fin_tuto.visible = true


func _on_fin_tuto_body_entered(body):
	if body.is_in_group("joueur_principale"):
		get_tree().change_scene_to_file("res://Scene/menu_option.tscn")
