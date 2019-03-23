extends Area2D

var player = ""
var power = 0.0

func hit_player(player):
	pass

func hit_edge():
	pass

func update(delta):
	pass

func created():
	pass

func _ready():
	created()

func _process(delta):
	update(delta)

func _on_area_entered(area):
	pass