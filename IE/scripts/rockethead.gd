extends "res://scripts/monster.gd"

var headOnShoulders = true
var rocketLoad = load("res://weaponsAndProjectiles/rocket.tscn");
var rocket
var parent
signal rip
func stats():
	parent = get_parent().get_parent()
	rocket = rocketLoad.instance()
	rocket.position = position
	connect("rip",rocket,"queue_free")
	call_deferred("summonRocket")
	rocket.rocketHead = self
	rocket.connect("died",self,"headIsBack")
	soul = 2
	attackOneCooldown = 5
	hp = 40
	speed = 30
func summonRocket():
	parent.add_child(rocket)
func attack1():
	$Rocket.visible = false
	rocket.position = position
	headOnShoulders = false
	rocket.rocketHead = self
	rocket.target = GameState.theMonster
	rocket.shoot()
	attackOneBool = false
	$AttackOne.start()

func ai():
	if headOnShoulders && toAttack:
		if attackOneBool:
			moving = false
			attack1()
	if GameState.theMonster != null && position.distance_to(GameState.theMonster.position - direction * 50) > 5:
		$NavigationAgent2D.set_target_location(GameState.theMonster.position)
		direction = position.direction_to($NavigationAgent2D.get_next_location())
func onDeath():
	emit_signal("rip")
func monsterExtra():
	if direction != Vector2.ZERO:
		$AnimationTree.get("parameters/playback").travel("walk")
	else:
		$AnimationTree.get("parameters/playback").travel("idle")
	if player:
		rocket.player = true
	else:
		rocket.player = false

func headIsBack():
	moving = true
	headOnShoulders = true
	$Rocket.visible = true
