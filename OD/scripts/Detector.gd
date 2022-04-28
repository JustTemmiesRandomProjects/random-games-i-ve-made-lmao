extends StaticBody2D

onready var hurtbox = $Hurtbox

export var colour = "Blue"

const DetectorHitSound = preload("res://scripts/DetectorHitSound.tscn")
const DetectorUnHitSound = preload("res://scripts/DetectorUnHitSound.tscn")

var ishit = 0

func _ready():
	if colour == "Blue":
		GameManager.BlueHit = 0
	elif colour == "Orange":
		GameManager.OrangeHit = 0

func _on_Hurtbox_area_entered(area):
	if colour == "Blue":
		GameManager.BlueHit = 1
	elif colour == "Orange":
		GameManager.OrangeHit = 1
	ishit = 1
	var hit = DetectorHitSound.instance()
	get_tree().current_scene.add_child(hit)


func _on_Hurtbox_area_exited(area):
	if colour == "Blue":
		GameManager.BlueHit = 0
	elif colour == "Orange":
		GameManager.OrangeHit = 0
	ishit = 0
	var unhit = DetectorUnHitSound.instance()
	get_tree().current_scene.add_child(unhit)
