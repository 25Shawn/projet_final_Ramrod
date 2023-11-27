extends Control

#var vie_ref : int = 0
func _ready():
#	var main_scene = get_tree().root
#	if main_scene:
#		vie_ref = main_scene.vie
#	print("Vie dans OtherScene:", vie_ref)
	pass
	$remplisement_vie.value = 100
func _on_hero_heatlh():
	$remplisement_vie.value = 100
