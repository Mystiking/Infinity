
extends Label

# member variables here, example:
# var a=2
# var b="textvar"
var akkum = 0

func _ready():
	# Initialization here
	set_process(true)
	

func _process(delta):
	akkum += delta
	set_text(str(akkum))


