extends Area2D

enum STATES {
	ATTACK,
	IDLE
}

export (float) var max_health = 100.0
export (int) var damage = 20

var state = STATES.IDLE

onready var animation_player = $AnimationPlayer

signal attack_finished

func _ready():
	add_to_group(Group.Weapon)
	animation_player.play("idle")
	animation_player.connect('animation_finished', self, '_on_AnimationPlayer_animation_finished')
	pass

func _process(delta):
	if state == STATES.ATTACK:
		for a in self.get_overlapping_areas():
			if a.is_in_group(Group.Enemy):
				a._on_hit(20)
	pass

func attack():
	animation_player.play("attack")
	_change_state(ATTACK)

func _change_state(new_state):
	match new_state:
		ATTACK:
			state = STATES.ATTACK
		IDLE:
			state = STATES.IDLE
			animation_player.play("idle")

func _on_AnimationPlayer_animation_finished(name):
	match name:
		"attack":
			_change_state(IDLE)
			emit_signal("attack_finished")