extends Sprite

const Note = preload("res://Note.tscn")

export (String, "p1", "p2") var PLAYER

onready var timer = $NoteStarts/Timer

var current_spell = {}
var current_note = 0
var notes_total = 0
var notes_hit = 0

func _ready():
	# set buttons to match board player
	for button in $Buttons.get_children():
		button.PLAYER = PLAYER
	
	# Test json spell loading
	current_spell = Spells.spells["fireball"]
	next_note()

func spawn_note(color, speed):
	var note = Note.instance()
	note.COLOR = color
	note.SPEED = speed
	
	get_node("NoteStarts/" + color).add_child(note)

func next_note():
	var note = current_spell["notes"][current_note]
	timer.wait_time = note["delay"]
	spawn_note(note["color"],note["speed"])
	
	if note["delay"] > 0:
		timer.start()
	else:
		_on_Timer_timeout()

func _on_Timer_timeout():
	current_note += 1
	
	if current_note >= len(current_spell["notes"]):
		current_note = 0
		return
	else:
		next_note()