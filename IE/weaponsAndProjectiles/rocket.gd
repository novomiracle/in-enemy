extends "res://scripts/projectile.gd"

var on = false
var target
var rocketHead
var explosion = load("res://weaponsAndProjectiles/explosion.tscn")
signal died

func shoot():
	on = true
	position = rocketHead.position
	direction = Vector2.RIGHT * rocketHead.scale.y
	#$CollisionTimer.start()
	$Timer.start()
	$projectile/CollisionShape2D.disabled = false
	visible = true

func _ready():
	visible = false
	speed = 45
	damage = 30

func die():
	if on:
		on = false
		visible = false
		emit_signal("died")
		call_deferred("kym")
func kym():
	$projectile/CollisionShape2D.disabled = true
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

func _on_projectile_area_entered(area):
	if area.name == "hitbox" && area!=rocketHead.get_node("hitbox"):
		if area.get_parent().player || player:
			area.get_parent().damage(damage,position,knockback)
		else:
			area.get_parent().damage(damage * GameState.friendlyFire,position,knockback)
		die()
#
#func _on_CollisionTimer_timeout():
#	#$projectile/CollisionShape2D.disabled = false
#	pass

func _on_VisibilityEnabler2D_screen_entered():
	if on:
		visible = true

