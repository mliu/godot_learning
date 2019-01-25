extends Area2D

export (int) var max_health = 100
export (int) var damage = 10

var current_health

func _ready():
	add_to_group(Group.Enemy)
	$AnimatedSprite.set_frame(randi() % $AnimatedSprite.frames.get_frame_count("default"));
	pass

func _process(delta):
	$AnimatedSprite.play()
	for a in get_overlapping_areas():
		if a.is_in_group(Group.Player):
			a.hit(damage)
	pass
