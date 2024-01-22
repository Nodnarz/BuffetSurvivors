extends Area2D

var level = 1
var hp = 2
var speed = 100
var damage = 5
var knockback_amount = 100
var attack_size = 1.0

var target = Vector2.ZERO
var angle = Vector2.ZERO

@onready var player = get_tree().get_first_node_in_group("player")
@onready var sprite_0 = preload("res://Uitily/Art/Weapons/knife_0.png")
@onready var sprite_1 = preload("res://Uitily/Art/Weapons/knife_1.png")
@onready var sprite_2 = preload("res://Uitily/Art/Weapons/knife_2.png")
@onready var sprite_3 = preload("res://Uitily/Art/Weapons/knife_3.png")
@onready var sprite_4 = preload("res://Uitily/Art/Weapons/knife_4.png")
signal remove_from_array(object)

func _ready():
	var sprite_number = randi_range(0,4)
	match sprite_number:
		0:
			$Sprite2D.texture = sprite_0
		1:
			$Sprite2D.texture = sprite_1
		2:
			$Sprite2D.texture = sprite_2
		3:
			$Sprite2D.texture = sprite_3
		4:
			$Sprite2D.texture = sprite_4
	angle = global_position.direction_to(target)
	rotation = angle.angle() + deg_to_rad(90)
	match level:
		1:
			hp = 1
			speed = 100
			damage = 5
			knockback_amount = 100
			attack_size = 1.0 * (1 + player.spell_size)
		2:
			hp = 1
			speed = 100
			damage = 5
			knockback_amount = 100
			attack_size = 1.0 * (1 + player.spell_size)
		3:
			hp = 2
			speed = 100
			damage = 8
			knockback_amount = 100
			attack_size = 1.0 * (1 + player.spell_size)
		4:
			hp = 2
			speed = 100
			damage = 8
			knockback_amount = 100
			attack_size = 1.0 * (1 + player.spell_size)
	
	var tween = create_tween()
	tween.tween_property(self,"scale",Vector2(1,1)*attack_size,1).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)
	tween.play()

func _physics_process(delta):
	position += angle*speed*delta
	
func enemy_hit(charge = 1):
	hp -= charge
	if hp <= 0:
		emit_signal("remove_from_array",self)
		queue_free()

func _on_timer_timeout():
	emit_signal("remove_from_array",self)
	queue_free()
