extends "res://scripts/monster.gd"


var laser = load("res://weaponsAndProjectiles/laser.tscn");
onready var parent = get_parent()

func stats():
	soul = 2
	attackOneCooldown = 3
	hp = 50
	speed = 50
func attack1():
	$AnimationTree.active = false
	$AnimationPlayer.play("attack")
	var inst = laser.instance()
	var inst2 = laser.instance()
	var inst3 = laser.instance()
	var projDir = (position.direction_to(GameState.theMonster.position)).normalized()
	if player:
		projDir = position.direction_to(get_global_mouse_position())
		inst.player = true
		inst2.player = true
		inst3.player = true
	var dir2 = projDir.rotated(0.5) 
	var dir3 = projDir.rotated(-0.5)
	inst.position = position + projDir*20
	inst2.position = position + dir2*20
	inst3.position = position + dir3*20
	inst.direction = projDir
	inst2.direction = dir2
	inst3.direction = dir3
	parent.add_child(inst)
	parent.add_child(inst2)
	parent.add_child(inst3)
	attackOneBool = false
	#strafeDir += Vector2(GameState.random.randf_range(-0.1,0.1),GameState.random.randf_range(-0.1,0.1))
	$AttackOne.start()
# Called when the node enters the scene tree for the first time.

func ai():
	if toAttack:
		moving = false
		if attackOneBool:
			attack1()
	elif GameState.theMonster != null && position.distance_to(GameState.theMonster.position) > 50:
		moving = true
		$NavigationAgent2D.set_target_location(GameState.theMonster.position)
		direction = position.direction_to($NavigationAgent2D.get_next_location())
		$NavigationAgent2D.set_target_location(GameState.theMonster.position)
		direction = position.direction_to($NavigationAgent2D.get_next_location())
func monsterExtra():
	if direction != Vector2.ZERO:
		$AnimationTree.get("parameters/playback").travel("walk")
	else:
		$AnimationTree.get("parameters/playback").travel("idle")
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "attack":
		$AnimationTree.active = true
