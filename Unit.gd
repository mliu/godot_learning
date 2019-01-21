extends Area2D

export (int) var max_health = 100

var current_health

func _ready():
	$AnimatedSprite.set_frame(randi() % $AnimatedSprite.frames.get_frame_count("default"));
	pass

func _process(delta):
	$AnimatedSprite.play()
	pass
