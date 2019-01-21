extends Area2D

export (int) var speed = 5
export(String) var weapon_scene_path = "res://Sword.tscn"

enum STATE {
	ATTACK,
	IDLE
}

var attack_state = IDLE
var flip_h
var screensize
var weapon

func _ready():
	screensize = get_viewport_rect().size
	
	# Weapon setup
	var weapon_instance = load(weapon_scene_path).instance()
	var weapon_anchor = $WeaponAnchorPoint
	weapon_anchor.add_child(weapon_instance)
	weapon = weapon_anchor.get_child(0)
	weapon.connect("attack_finished", self, "_on_Weapon_attack_finished")
	pass
	
func _maybe_flip():
	if attack_state != ATTACK:
		self.set_scale(Vector2(flip_h, 1))

func _input(ev):
	match attack_state:
		IDLE:
			if ev is InputEventKey and ev.is_pressed() and ev.scancode == KEY_Z:
				attack_state = ATTACK
				weapon.attack()
	pass
	
func _on_Weapon_attack_finished():
	attack_state = IDLE
	self._maybe_flip()

func _process(delta):
	var velocity = Vector2() # The player's movement vector.
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite.play("walk")
		if velocity.x != 0:
			flip_h = -1 if velocity.x < 0 else 1 
			self._maybe_flip()
	else:
		$AnimatedSprite.play("idle")
	position += velocity * delta
	position.x = clamp(position.x, 0, screensize.x)
	position.y = clamp(position.y, 0, screensize.y)
	pass
