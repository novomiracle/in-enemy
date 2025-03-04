extends "res://scripts/projectile.gd"

var on = false
var target
var rocketHead
var explosion = load("res://weaponsAndProjectiles/explosion.tscn")
signal died
func shoot():
	on = true
	visible = true
	$projectile/CollisionShape2D.disabled = true
	position = rocketHead.position
	direction = Vector2.RIGHT * rocketHead.scale.y
	$CollisionTimer.start()
	$Timer.start()

func _ready():
	visible = false
	speed = 40
	damage = 30

func die():
	if on:
		call_deferred("kym")
		on = false
		$projectile/CollisionShape2D.disabled = true
		visible = false
		emit_signal("died")
func kym():
	var inst = explosion.instance()
	inst.position = position
	get_parent().add_child(inst)
func trajectory():
	if on:
		if player:
			direction = position.direction_to(get_global_mouse_position())
		else:
			direction = position.direction_to(target.position)
		rotation_degrees =rad2deg( Vector2.RIGHT.angle_to(direction))

func _on_Timer_timeout():
	die()


func _on_CollisionTimer_timeout():
	$projectile/CollisionShape2D.disabled = false

func _on_VisibilityEnabler2D_screen_entered():
	if on:
		visible = true

