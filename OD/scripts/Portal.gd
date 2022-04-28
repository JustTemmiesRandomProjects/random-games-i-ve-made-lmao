extends Area2D

export(PackedScene) var target_scene
var nextlevel = 1

func _process(delta):
	if GameManager.BlueHit == 1:
		if GameManager.OrangeHit == 1:
			if nextlevel == 1:
				
				if !target_scene: # is null:
					print("no specified scene")
					return
				if get_overlapping_bodies().size() > 0:
					$AnimatedSprite.play("Teleport")
					$AnimationPlayer.play("Open")
				else:
					$AnimatedSprite.play("Active")
					$AnimationPlayer.stop()
					
	if GameManager.BlueHit == 0 or GameManager.OrangeHit == 0:
		$AnimatedSprite.play("Inactive")
		$AnimationPlayer.stop()

func next_level():
	if get_overlapping_bodies().size() > 0:
		var ERR = get_tree().change_scene_to(target_scene)

		if ERR != OK:
			print("something in the portal script diedified :(")
