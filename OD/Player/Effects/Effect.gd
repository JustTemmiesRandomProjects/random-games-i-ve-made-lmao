extends AnimatedSprite


func _ready():
# warning-ignore:return_value_discarded
	connect("animation_finished", self, "_on_animation_finished")
	#start with self.connect if it's a different node that had a signal
	#the signal to connect to
	#the object or node that has the function
	#and the function we're connecting to
	play("Animate")	


func _on_animation_finished():
	queue_free()
