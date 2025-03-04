extends "res://scripts/monster.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var flyingSpeed = 100;
var landingVector = Vector2(0,0);
var landingPos = Vector2(0,0);
func stats():
	soul = 1
	hp = 80
	knockback = 300
	attackOneCooldown = 3
	knockbackResistance = 90
	speed = 45
	damage = 25

func attack1():
	$AnimationTree.active = false
	$AnimationPlayer.play("jump")
	attackOneBool = false
	moving = false
	if player:
		landingPos =get_global_mouse_position()
	else:
		landingPos = GameState.theMonster.position
	$AttackOne.start()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func ai():
	#print(attackOneBool)
	if !flying:
		moving = false
		if toAttack:
			if attackOneBool:
				attack1()
		else:
			moving = true
			if GameState.theMonster != null:
				$NavigationAgent2D.set_target_location(GameState.theMonster.position)
				direction = position.direction_to($NavigationAgent2D.get_next_location())
func monsterExtra():
	if flying:
		if position.distance_to(landingPos) > 20:
			landingVector = (landingPos - position).normalized()
			move_and_slide(landingVector.normalized()*flyingSpeed)
		else:
			toLand()
func toLand():
	$AnimationTree.active = false
	$AnimationPlayer.play("land")
	land(true)

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "jump":
		$AnimationTree.active = true
		fly(true)
		$AnimationTree.get("parameters/playback").travel("flying")
	elif anim_name == "land":
		moving = true
		$AnimationTree.active = true
		$AnimationPlayer.play("walk")
