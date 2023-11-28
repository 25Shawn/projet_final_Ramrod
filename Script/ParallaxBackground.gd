extends ParallaxBackground
#Fait par Shawn Dutil

func _process(delta):
	scroll_base_offset -= Vector2(100, 0) * delta
