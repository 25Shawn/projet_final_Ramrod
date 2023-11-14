extends Area2D
@export var dommage = 5


func _on_body_entered(body):
	if body.is_in_group("joueur_principale"):
		var vie_joueur = body.vie
		$Timer.start()
		vie_joueur -= dommage
		if vie_joueur <= 0:
			body.queue_free()
		
		print(vie_joueur)
		
func _on_timer_timeout():
	$Timer.stop()
