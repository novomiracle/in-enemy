extends "res://scripts/monster.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var magic_circle = load("res://weaponsAndProjectiles/dark_circle.tscn");
onready var parent = get_parent()

func stats():
	soul = 2
	attackOneCooldown = 2.5
	hp = 50
	speed = 90
func attack1():
	$AnimationPlayer.play("attack")
	var inst = magic_circle.instance()
	inst.position = GameState.theMonster.position;
	if player:
		inst.position = get_global_mouse_position()
		inst.player = true
	parent.add_child(inst)
	attackOneBool = false
	#strafeDir += Vector2(GameState.random.randf_range(-0.1,0.1),GameState.random.randf_range(-0.1,0.1))
	$AttackOne.start()
# Called when the node enters the scene tree for the first time.

func ai():
	#print(toAttack)
	if toAttack:
		if attackOneBool:
			attack1()
	if GameState.theMonster != null:
		if  position.distance_to(GameState.theMonster.position) > 100:
			$NavigationAgent2D.set_target_location(GameState.theMonster.position)
			direction = position.direction_to($NavigationAgent2D.get_next_location())
		else:
			direction = Vector2.ZERO
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "attack":
		$AnimationPlayer.play("walk")
