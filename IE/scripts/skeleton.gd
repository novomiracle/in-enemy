extends "res://scripts/monster.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var strafeDir = Vector2(0,0);
var arrow = load("res://weaponsAndProjectiles/arrow.tscn");
onready var parent = get_parent()

func stats():
	soul = 1
	attackOneCooldown = 2.5
	hp = 45
	speed = 30
func attack1():
	$AnimationTree.active = false
	$AnimationPlayer.play("attack")
	var inst = arrow.instance()
	var projDir = (position.direction_to(GameState.theMonster.position)+Vector2(GameState.random.randf_range(-0.3,0.3),GameState.random.randf_range(-0.3,0.3))).normalized()
	if player:
		projDir = position.direction_to(get_global_mouse_position())
		inst.player = true
	inst.position = position + projDir*20
	inst.direction = projDir
	parent.add_child(inst)
	attackOneBool = false
	#strafeDir += Vector2(GameState.random.randf_range(-0.1,0.1),GameState.random.randf_range(-0.1,0.1))
	$AttackOne.start()
# Called when the node enters the scene tree for the first time.

func ai():
	#print(toAttack)
	if toAttack && position.distance_to(GameState.theMonster.position) > 50:
		if attackOneBool:
			attack1()
	if GameState.theMonster != null && position.distance_to(GameState.theMonster.position - direction * 50) > 5:
		$NavigationAgent2D.set_target_location(GameState.theMonster.position)
		direction = position.direction_to($NavigationAgent2D.get_next_location())
		$NavigationAgent2D.set_target_location(GameState.theMonster.position - (direction + strafeDir).normalized() * 50)
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
