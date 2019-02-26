extends Area2D

export (String, "red", "blue", "green", "purple") var COLOR
export (int) var SPEED = 240

onready var sprite = $Sprite
onready var tween = $Tween

var dead = false

func _ready():
	# Change graphics depending on note type
	match COLOR:
		"red":
			sprite.region_rect.position.x = 0
			$DeathParticles.modulate = Color(1,0.4,0.4)
		"blue":
			sprite.region_rect.position.x = 32
			$DeathParticles.modulate = Color(0.33,0.9,0.8)
		"green":
			sprite.region_rect.position.x = 64
			$DeathParticles.modulate = Color(0.5,0.9,0.33)
		"purple":
			sprite.region_rect.position.x = 96
			$DeathParticles.modulate = Color(0.7,0.5,0.8)

func _process(delta):
	if not dead:
		position.y += SPEED * delta
	
	if Input.is_action_just_pressed("ui_accept"):
		explode()

func explode():
	if dead: return
	
	dead = true
	tween.interpolate_property(sprite, "transform",
		sprite.transform, sprite.transform.scaled(Vector2(0,0)),
		0.3, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	tween.start()
	$DeathTimer.start()
	$DeathParticles.emitting = true