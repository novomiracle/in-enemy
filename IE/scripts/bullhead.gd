extends "res://scripts/monster.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var dashDirection = Vector2.ZERO;
func stats():
	knockbackResistance = 50
	attackOneCooldown = 3.8
	attackTwoCooldown= 0.5
	knockback = 250
	soul = 2
	damage = 35
	hp = 80
	speed = 60


func attack1():
	$AnimationTree.active = false
	moving = false
	$AnimationPlayer.play("ready")
	attackOneBool = false
	$AttackOne.start()
func ai():
	if toAttack:
		if attackOneBool:
			attack1()
	elif GameState.theMonster != null:
		$AnimationTree.get("parameters/playback").travel("walk")
		$NavigationAgent2D.set_target_location(GameState.theMonster.position)
		direction = position.direction_to($NavigationAgent2D.get_next_location())

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "ready":
		$AnimationTree.active = true
		if player:
			dashDirection =position.direction_to(get_global_mouse_position()) 
		else:
			$NavigationAgent2D.set_target_location(GameState.theMonster.position)
			dashDirection = position.direction_to($NavigationAgent2D.get_next_location())
		knock(400/(1-(knockbackResistance / 100)),dashDirection.normalized())
		$AnimationTree.get("parameters/playback").travel("attack")
		attackTwoBool = false
		$AttackTwo.start()

func _on_AttackTwo_timeout():
	$AnimationTree.get("parameters/playback").travel("walk")
	moving = true
	$AttackTwo.stop()
