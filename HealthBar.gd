extends Node2D

var percentage_fill = 1

onready var tween = $HealthTween

func _ready():
	pass
	
func _process(delta):
	$HealthBar.value = percentage_fill

func _on_update_health(new_value):
	tween.interpolate_property(self, "percentage_fill", percentage_fill, new_value, 0.2, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	if not tween.is_active():
		tween.start()
	pass
