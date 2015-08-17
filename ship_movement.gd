
extends Environment

# Might come in useful when asteroids are added (soon^tm)
var ship_size

func _ready():
	ship_size = get_node("Ship").get_texture().get_size()
	set_process(true)


func _process(delta):
	# The velocity and position of the ship
	var ship_speed = 0
	var ship_pos = get_node("Ship")
