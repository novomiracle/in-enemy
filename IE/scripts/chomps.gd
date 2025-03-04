extends "res://scripts/monster.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func stats():
	soul = 1
	attackOneCooldown = 2
	knockback = 180
	damage = 20
	hp = 100
	speed = 50

# Called when the node enters the scene tree for the first time.
func attack1():
	$AnimationPlayer.play("attack")
	moving = false
	$AnimationTree.active = false
	attackOneBool = false
	$AttackOne.start()
func ai():
	if toAttack:
		if attackOneBool:
			attack1()
	elif moving:
		if GameState.theMonster != null:
			$NavigationAgent2D.set_target_location(GameState.theMonster.position)
			direction = position.direction_to($NavigationAgent2D.get_next_location())

func monsterExtra():
	if direction != Vector2.ZERO:
		$AnimationTree.get("parameters/playback").travel("walk")
	else:
		$AnimationTree.get("parameters/playback").travel("idle")

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "attack":
		moving = true
		$AnimationTree.active = true
