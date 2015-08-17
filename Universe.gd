
extends Node2D

# Might come in useful when asteroids are added (soon^tm)
var ship_size

# Velocity and accelerate
var ship_velocity = Vector2(0, 0)
var ship_accelerate = Vector2(0, -1)

func _ready():
	ship_size = get_node("Ship").get_texture().get_size()
	set_process(true)


func _process(delta):
	# The velocity and position of the ship
	var ship_pos = get_node("Ship").get_pos() + ship_velocity * delta
	var ship_tip = Vector2(get_node("Ship").get_pos().x, get_node("Ship").get_pos().y - 63)
	var ship_vector = ship_tip - ship_pos
	
	# The forward movement of the spaceship
	if (Input.is_action_pressed("ship_forward")):
		get_node("Acceleration").set_text("Acceleration" + str(ship_accelerate))
		get_node("Velocity").set_text("Velocity" + str(ship_velocity))		
		ship_velocity += ship_accelerate
		ship_pos += ship_velocity * delta
	else:
		ship_pos += ship_velocity * delta
		get_node("Acceleration").set_text("Acceleration" + str(ship_accelerate))
		get_node("Velocity").set_text("Velocity" + str(ship_velocity))
	
	# All rotating is calculated by multiplying the accelerate vector with a "turn matrix"
	# Creation of turn right matrix
	var m_r = Matrix32()
	m_r[0] = Vector2(cos(0.08), sin(0.08))
	m_r[1] = Vector2(-sin(0.08), cos(0.08))
	
	# Creation of turn left matrix
	var m_l = Matrix32()
	m_l[0] = Vector2(cos(-0.08), sin(-0.08))
	m_l[1] = Vector2(-sin(-0.08), cos(-0.08))
	
	# Turning right
	if (Input.is_action_pressed("ship_turn_right")):
		ship_accelerate = m_r * ship_accelerate
		get_node("Acceleration").set_text("Acceleration" + str(ship_accelerate))
		get_node("Velocity").set_text("Velocity" + str(ship_velocity))
		get_node("Ship").set_rot(get_node("Ship").get_rot() - 0.08)
		
	# Turning left
	if (Input.is_action_pressed("ship_turn_left")):
		ship_accelerate = m_l * ship_accelerate
		get_node("Acceleration").set_text("Acceleration" + str(ship_accelerate))
		get_node("Velocity").set_text("Velocity" + str(ship_velocity))
		get_node("Ship").set_rot(get_node("Ship").get_rot() + 0.08)
		
	get_node("Ship").set_pos(ship_pos)