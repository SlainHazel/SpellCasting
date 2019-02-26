extends Area2D

export (String, "p1", "p2") var PLAYER = "p1"
export (String, "red", "blue", "green", "purple") var COLOR

signal pressed(color)
signal released(color)
signal note_hit(color)

onready var depression_timer = $DepressionTimer
onready var sprite = $Sprite

onready var sound_hit = $SoundHit
onready var sound_miss = $SoundMiss

var depressed = false

func _ready():
	match COLOR:
		"red":
			sprite.region_rect.position.x = 0
			sound_hit.pitch_scale = 0.85
			sound_miss.pitch_scale = 0.85
		"blue":
			sprite.region_rect.position.x = 30
			sound_hit.pitch_scale = 0.95
			sound_miss.pitch_scale = 0.95
		"green":
			sprite.region_rect.position.x = 60
			sound_hit.pitch_scale = 0.05
			sound_miss.pitch_scale = 0.05
		"purple":
			sprite.region_rect.position.x = 90
			sound_hit.pitch_scale = 0.15
			sound_miss.pitch_scale = 0.15

func _physics_process(delta):
	if Input.is_action_pressed(PLAYER + "_" + COLOR):
		sprite.visible = false
	else:
		sprite.visible = not depressed
	
	if Input.is_action_just_pressed(PLAYER + "_" + COLOR):
		depressed = true
		depression_timer.start()
		
		if len(get_overlapping_areas()) == 0:
			sound_miss.play()
		else:
			sound_hit.play()
			for note in get_overlapping_areas():
				note.explode()

func _on_depression_done():
	depressed = false