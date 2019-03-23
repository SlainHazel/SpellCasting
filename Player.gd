extends Area2D

export (String, "p1", "p2") var PLAYER = "p1"

var buttons = {}

var speed = 160

var max_health = 100
var health = max_health

var can_move = true

func _ready():
	buttons = {
		"up": PLAYER + "_up",
		"down": PLAYER +  "_down",
		"left": PLAYER +  "_left",
		"right": PLAYER +  "_right",
		"confirm": PLAYER +  "_confirm"
	}

func _process(delta):
	if can_move:
		if Input.is_action_pressed(buttons["up"]):
			position.y -= speed * delta
		if Input.is_action_pressed(buttons["down"]):
			position.y += speed * delta