extends Area2D
@export var dommage = 5

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	if body.is_in_group("joueur_principale"):
		var vie_joueur = body.vie
		$Timer.start()
		vie_joueur -= dommage
		if vie_joueur <= 0:
			body.queue_free()
		
		print(vie_joueur)


func _on_timer_timeout():
	pass # Replace with function body.
