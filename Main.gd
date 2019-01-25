extends Node

onready var health_bar = $HealthBarContainer
onready var player = $Player

func _ready():
	randomize() 
	player.connect("update_health", health_bar, "_on_update_health")
	pass
	
func _process(delta):
	health_bar.set_position(player.position)
	pass
