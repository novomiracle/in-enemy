extends "res://scripts/monster.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
# Called when the node enters the scene tree for the first time.
#func _ready():
func stats():
	attackOneCooldown = 2
	knockback = 220
	damage = 10
	soul = 1
	hp = 50
	speed = 100
func ai():
	if toAttack:
		if attackOneBool:
			attack1()
	else:
		if GameState.theMonster != null:
			$NavigationAgent2D.set_target_location(GameState.theMonster.position)
			direction = position.direction_to($NavigationAgent2D.get_next_location())
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func attack1():
	$AnimationPlayer.play("attack")
	attackOneBool = false
	$AnimationTree.active = false
	$AttackOne.start()
func monsterExtra():
	#print("goblin collision ",collision_layer,collision_mask)
	if direction != Vector2.ZERO:
		$AnimationTree.get("parameters/playback").travel("walk")
	else:
		$AnimationTree.get("parameters/playback").travel("idle")


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "attack":
		$AnimationTree.active = true
