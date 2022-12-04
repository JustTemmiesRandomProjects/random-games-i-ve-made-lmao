extends Node

var languages = ["en", "fr", "nb"]
var language = 0

func _ready():
	TranslationServer.set_locale(languages[language])

func _unhandled_key_input(event):
	if Input.get_action_raw_strength("ui_accept"):
		language += 1
		if language >= len(languages):
			language = 0
		
		TranslationServer.set_locale(languages[language])
