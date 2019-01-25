extends Area2D

export (float) var max_health = 100.0
export (int) var damage = 15

var health = max_health

signal update_health(new_value)

func _ready():
	add_to_group(Group.Enemy)
	$AnimatedSprite.set_frame(randi() % $AnimatedSprite.frames.get_frame_count("default"));
	self.connect("update_health", $HealthBarContainer, "_on_update_health")
	pass

func _process(delta):
	$AnimatedSprite.play()
	for a in get_overlapping_areas():
		if a.is_in_group(Group.Player):
			a.hit(damage)
	pass
	
func _on_death():
	$AnimationPlayer.play("death")
	yield($AnimationPlayer, "animation_finished")
	queue_free()
	pass
	
func _on_hit(damage):
	if ($InvincibleTimer.is_stopped() && health > 0):
		health -= damage
		emit_signal("update_health", health / max_health)
		if (health <= 0):
			_on_death()
		else:
			$AnimationPlayer.play("hit")
		$InvincibleTimer.start()
	pass
