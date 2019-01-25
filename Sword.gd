extends Area2D

signal attack_finished

enum STATES {IDLE, ATTACK}

onready var animation_player = $AnimationPlayer

func _ready():
	add_to_group(Group.Weapon)
	animation_player.play("idle")
	animation_player.connect('animation_finished', self, '_on_AnimationPlayer_animation_finished')
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func attack():
	animation_player.play("attack")
	_change_state(ATTACK)

func _change_state(new_state):
	match new_state:
		ATTACK:
			return true
		IDLE:

			animation_player.play("idle")

func _on_AnimationPlayer_animation_finished(name):
	match name:
		"attack":
			_change_state(IDLE)
			emit_signal("attack_finished")