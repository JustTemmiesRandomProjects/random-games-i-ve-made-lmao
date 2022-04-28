extends Control


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"

var words = [
"makt",
"terror",
"krig",
"diktatur",
"vold",
"terrorist",
"sivil",
"samfunn",
"misbruk",
"bombe"]

var gotit = [false,false,false,false,false,false,false,false,false,false]

var i = 0
var lose = true

func _process(delta: float) -> void:
	
	i=0
	if $TextEdit1.text == words[i]:
		gotit[i] = true
	else:
		gotit[i] = false
	i=1
	if $TextEdit2.text == words[i]:
		gotit[i] = true
	else:
		gotit[i] = false
	i=2
	if $TextEdit3.text == words[i]:
		gotit[i] = true
	else:
		gotit[i] = false
	i=3
	if $TextEdit4.text == words[i]:
		gotit[i] = true
	else:
		gotit[i] = false
	i=4
	if $TextEdit5.text == words[i]:
		gotit[i] = true
	else:
		gotit[i] = false
	i=5
	if $TextEdit6.text == words[i]:
		gotit[i] = true
	else:
		gotit[i] = false
	i=6
	if $TextEdit7.text == words[i]:
		gotit[i] = true
	else:
		gotit[i] = false
	i=7
	if $TextEdit8.text == words[i]:
		gotit[i] = true
	else:
		gotit[i] = false
	i=8
	if $TextEdit9.text == words[i]:
		gotit[i] = true
	else:
		gotit[i] = false
	i=9
	if $TextEdit10.text == words[i]:
		gotit[i] = true
	else:
		gotit[i] = false
	
	for x in len(gotit):
		if not gotit[x]:
			lose = true
	
	if not lose:
		print("win")
		$Popup.show()
	
	lose = false
	
