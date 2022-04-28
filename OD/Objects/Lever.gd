extends KinematicBody2D

onready var sprite = $AnimatedSprite
onready var hurtbox = $Hurtbox

export var LorRstate = "left"
export var orange1blue0 = 1

func _ready():
	if LorRstate == "left":
		sprite.play("staticLeft")
	else:
		sprite.play("staticRight")

func _on_Hurtbox_area_entered(area):
	if LorRstate == "left":
		sprite.play("ltr")
		LorRstate = "right"
		if orange1blue0:
			GameManager.orangeL = 1
		else:
			GameManager.blueL = 1
	else:
		sprite.play("rtl")
		LorRstate = "left"
		if orange1blue0:
			GameManager.orangeL = 0
		else:
			GameManager.blueL = 0
	#print("ouch")
	#sprite.flip_h
