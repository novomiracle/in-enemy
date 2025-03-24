extends KinematicBody2D

export var spawnOnReady = false
export var removeOnScreenExit = false
var direction = Vector2.ZERO
var damage = 5
var knockback = 0
var player = false
var hurt = false

func _ready():
	if spawnOnReady:
		spawn()
func die():
	queue_free()
func spawn():
	hurt = true
	on_spawn()
	$Timer.start()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func on_spawn():
	for area in $damage.get_overlapping_areas():
		if area.is_in_group("hitbox"):
			if area.get_parent().player || player:
				area.get_parent().damage(damage,position,knockback)
			else:
				area.get_parent().damage(damage * GameState.friendlyFire,position,knockback)

func _on_VisibilityNotifier2D_screen_exited():
	if removeOnScreenExit:
		queue_free()
	else:
		visible = false

func _on_VisibilityEnabler2D_screen_entered():
	visible = true

func _on_damage_area_entered(area):
	if area.is_in_group("hitbox") && hurt:
		if area.get_parent().player || player:
			area.get_parent().damage(damage,position,knockback)
		else:
			area.get_parent().damage(damage * GameState.friendlyFire,position,knockback)

func _on_Timer_timeout():
	die()
