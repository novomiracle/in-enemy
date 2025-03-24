extends KinematicBody2D

export var spawnOnReady = false
export var removeOnScreenExit = false
var damage = 5
var knockback = 0
var player = false
var hurt = false
func stats():
	pass
func _ready():
	stats()
	if spawnOnReady:
		spawn()
func die():
	queue_free()
func spawn():
	print("spawn")
	hurt = true
	on_spawn()
	$Timer.start()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func on_spawn():
#	for area in $damage.get_overlapping_areas():
#		if area.is_in_group("hitbox"):
#			if area.get_parent().player || player:
#				area.get_parent().damage(damage,position,knockback)
#			else:
#				area.get_parent().damage(damage * GameState.friendlyFire,position,knockback)
	pass

func _on_VisibilityNotifier2D_screen_exited():
	if removeOnScreenExit:
		queue_free()
	else:
		visible = false

func _on_VisibilityEnabler2D_screen_entered():
	visible = true

func _on_damage_area_entered(area):
	if area.is_in_group("hitbox") && hurt:
		print("dmg",hurt)
		if area.get_parent().player || player:
			area.get_parent().damage(damage,position,knockback)
		else:
			area.get_parent().damage(damage * GameState.friendlyFire,position,knockback)




func _on_Timer_timeout():
	if hurt:
		for area in $damage.get_overlapping_areas():
			if area.is_in_group("hitbox"):
				if area.get_parent().player || player:
					area.get_parent().damage(damage,position,knockback)
				else:
					area.get_parent().damage(damage * GameState.friendlyFire,position,knockback)
