extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var shootOnReady = true
export var removeOnScreenExit = true
var speed = 200;
var direction = Vector2.ZERO
var damage = 5
var knockback = 0
var player = false
# Called when the node enters the scene tree for the first time.
func _ready():
	if shootOnReady:
		shoot()
func die():
	queue_free()
func shoot():
	pass
func trajectory():
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	trajectory()
	move_and_slide(direction.normalized() * speed)


func _on_projectile_area_entered(area):
	if area.name == "hitbox":
		if area.get_parent().player || player:
			area.get_parent().damage(damage,position,knockback)
		else:
			area.get_parent().damage(damage * GameState.friendlyFire,position,knockback)
		die()
func _on_VisibilityNotifier2D_screen_exited():
	if removeOnScreenExit:
		queue_free()
	else:
		visible = false


func _on_VisibilityEnabler2D_screen_entered():
	visible = true
