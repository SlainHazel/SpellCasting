extends Node

const projectiles = {}

var spells = {}

func _ready():
	var dir = Directory.new()
	dir.open("res://spells")
	dir.list_dir_begin()
	while true:
		var file = dir.get_next()
		if file == "":
			break
		elif file.ends_with(".json"):
			load_spell(file)

func load_spell(name):
	var file = File.new()
	file.open("res://spells/" + name, File.READ)
	var text = file.get_as_text()
	var spell = JSON.parse(text).result
	spells[spell["id"]] = spell
	file.close()