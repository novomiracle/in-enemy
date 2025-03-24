extends KinematicBody2D

export var spawnOnReady = true
export var removeOnScreenExit = false
var speed = 200;
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
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	move_and_slide(direction.normalized() * speed)


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
