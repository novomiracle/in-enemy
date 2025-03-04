extends "res://scripts/monster.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var slash = load("res://weaponsAndProjectiles/slash.tscn")
onready var parent = get_parent()
var dashDirection = Vector2.ZERO;
func stats():
	knockbackResistance = 20
	attackOneCooldown = 3
	soul = 2
	hp = 50
	speed = 55
	fly()


func attack1():
	$AnimationTree.active = false
	$AnimationPlayer.play("attack")
	print(slash)
	var inst = slash.instance()
	var projDir = (position.direction_to(GameState.theMonster.position)+Vector2(GameState.random.randf_range(-0.3,0.3),GameState.random.randf_range(-0.3,0.3))).normalized()
	if player:
		projDir = position.direction_to(get_global_mouse_position())
		inst.player = true
	inst.position = position + projDir*20
	inst.direction = projDir
	parent.add_child(inst)
	attackOneBool = false
	$AttackOne.start()
func ai():
	if toAttack:
		if attackOneBool:
			attack1()
			moving = false
	elif GameState.theMonster != null:
			moving = true
			$NavigationAgent2D.set_target_location(GameState.theMonster.position)
			direction = position.direction_to($NavigationAgent2D.get_next_location())


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "attack":
		$AnimationTree.active = true
