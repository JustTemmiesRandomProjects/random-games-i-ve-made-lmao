extends Particles2D



func _on_Timer_timeout():
	var scene = load("res://Enemy.tscn")
	var scene_instance = scene.instance()
	scene_instance.position = position
	
	get_tree().get_root().add_child(scene_instance)
	queue_free()

