extends Node2D

func spawn_particle():
	var x = rand_range(50,950)
	var y = rand_range(50,550)
	
	var scene = load("res://enemyspawn.tscn")
	var scene_instance = scene.instance()
	scene_instance.position = Vector2(x,y)
	
	if rand_range(0,9) >= 2:
		spawn_particle()		
	add_child(scene_instance)
