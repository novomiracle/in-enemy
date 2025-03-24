extends KinematicBody2D

signal tookDamage
signal died
signal attack1
var movingSpeed:float
var damageAnimation:bool = false;
var flying:bool = false
export var ai:bool = true;
var moving:bool = true;
var toAttack:bool = false
var soul:int = 1;
var damageCooldown:float = 0.5
var attackOneCooldown:float = 2;
var attackTwoCooldown:float = 3;
var attackOneBool:bool = true
var attackTwoBool:bool = true
export var player = false;
var hurt = false;
var hp:int = 100;
var maxHp:int = 100;
var speed:float = 100;
var damage:int = 10;
var knocked:float = 0;
var knockback:float = 220;
var knockbackResistance:float = 0;
var knockbackDirection:Vector2 = Vector2.ZERO
var direction = Vector2.ZERO
#onready var shader = $Sprite.material.duplicate();
# Called when the node enters the scene tree for the first time.
func _ready():
	#print("pleayer ",player)
	$healthbar.value = maxHp
	set_collision_layer_bit(1,false)
	set_collision_mask_bit(1,false)
	set_collision_layer_bit(0,true)
	set_collision_mask_bit(0,true)
	#$AnimationTree.get("parameters/playback").start("idle")
	#print($AnimationTree.get("parameters/playback").is_playing())
	GameState.connect("switch",self,"switchesScript")
	stats()
	maxHp = hp
	$DamageTimer.wait_time = damageCooldown
	if player:
		$CollisionShape2D.disabled = false
		GameState.theMonster = self
		movingSpeed = speed * GameState.playerSpeedBoost
		GameState.emit_signal("switch")
		#connect("tookDamage",get_parent().get_parent().get_node("cameraman"),"shake")
		#connect("died",get_tree().current_scene,"switch_to_lose_screen")
		$Sprite.material = GameState.outlineShader
		$AttackOne.wait_time = attackOneCooldown/GameState.playerAttackSpeedBoost
		$AttackTwo.wait_time = attackTwoCooldown/GameState.playerAttackSpeedBoost
	else:
		movingSpeed = speed
		$AttackOne.wait_time = attackOneCooldown
		$AttackTwo.wait_time = attackTwoCooldown
func stats():
	pass
func switchesScript():
	for i in $attack_range.get_overlapping_areas():
		if i == GameState.theMonster.get_node("hitbox"):
			toAttack = true
			break
		toAttack = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
func switched():
	disconnect("died",get_tree().current_scene,"switch_to_lose_screen")
	disconnect("attack1",GameState.cooldown,"reset")
	disconnect("tookDamage",GameState.cameraMan,"shake")
	$AttackOne.wait_time = attackOneCooldown
	$AttackTwo.wait_time = attackTwoCooldown
	movingSpeed = speed
func _physics_process(delta):
	if player:
		playerPlus()
		playerScript()
	elif ai:
		if direction.x > 0:
			scale.y =  1
			rotation_degrees = 0
			$healthbar.rect_scale.y = 1
			$healthbar.rect_rotation = 0
		else:
			scale.y =  -1
			rotation_degrees = 180
			$healthbar.rect_scale.y = -1
			$healthbar.rect_rotation = 180
		ai()
	if moving:
		move_and_slide(direction.normalized()*movingSpeed)
	monsterExtra()
	knockback()

func playerScript():
	direction = Vector2.ZERO
	if get_global_mouse_position().x < position.x:
		$healthbar.rect_scale.y = -1
		$healthbar.rect_rotation = 180
		scale.y = -1
		rotation_degrees = 180
	else:
		$healthbar.rect_scale.y = 1
		$healthbar.rect_rotation = 0
		scale.y = 1
		rotation_degrees = 0
	#movement
	direction.y = Input.get_axis("up","down")
	direction.x = Input.get_axis("left","right")
	
	if Input.is_action_just_pressed("attack1") && attackOneBool:
		emit_signal("attack1")
		attack1()
		attackOneBool = false
		$AttackOne.start()
#	if Input.is_action_just_pressed("attack2") && attackTwoBool:
#		attack2()
#		attackTwoBool = false
#		$AttackTwo.start()
func playerPlus():
	pass
func attack1():
	pass
func attack2():
	pass
func monsterExtra():
	pass
func damage(dmg,pos,kn):
	#$Sprite.material = shader
	if !hurt:
		if player && dmg >= maxHp/2:
			emit_signal("tookDamage")
		hp -= dmg
		$healthbar.value = 100*hp/maxHp
		knock(kn,(position-pos).normalized())
		$damageAnimation.play("damage")
		hurt = true
		$DamageTimer.start()
		die()
func fly(jump:bool = false):
	z_index = 1
	flying = true
	$Sprite.modulate.a = 0.9
	#layer
	set_collision_layer_bit(0,false)
	set_collision_layer_bit(1,true)
	if jump:
		$Sprite.modulate.a = 0.5
		$hitbox.set_collision_layer_bit(0,false)
		$hitbox.set_collision_layer_bit(1,true)
		
		$hitbox.set_collision_mask_bit(0,false)
		$hitbox.set_collision_mask_bit(1,true)
		$CollisionShape2D.disabled = true
	#mask
	set_collision_mask_bit(0,false)
	set_collision_mask_bit(1,true)
	
func land(jump:bool = false):
	z_index = 0
	$Sprite.modulate.a = 1
	flying = false
	#layer
	set_collision_layer_bit(0,true)
	set_collision_layer_bit(1,false)
	if jump:
		$hitbox.set_collision_layer_bit(0,true)
		$hitbox.set_collision_layer_bit(1,false)
		$hitbox.set_collision_mask_bit(0,true)
		$hitbox.set_collision_mask_bit(1,false)
		
		$CollisionShape2D.disabled = false
	#mask
	set_collision_mask_bit(0,true)
	set_collision_mask_bit(1,false)
func knock(kn,direction):
	knockbackDirection = direction
	knocked  = kn * (1-(knockbackResistance / 100))
	#print("knocked = ",knocked,"resistance =",knockbackResistance," ",(1-(knockbackResistance / 100)))
func knockback():
	knocked = max(0, knocked * 0.9-1)
	#prinst("kn ", knocked)
	move_and_slide(knocked* knockbackDirection.normalized())

func _on_Timer_timeout():
	hurt = false


func _on_AttackTwo_timeout():
	attackTwoBool = true


func _on_AttackOne_timeout():
	attackOneBool = true

func ai():
	pass
func die():
	if hp <= 0:
		if player:
			emit_signal("died")
			onDeath()
			pass
		else:
			#will drop them
			for i in soul:
				call_deferred("dropSoul")
			queue_free()
			onDeath()
func onDeath():
	pass
func dropSoul():
	var inst = GameState.soulScene.instance()
	inst.position = position + Vector2(GameState.random.randi_range(-5,5),GameState.random.randi_range(-5,5))
	inst.position = inst.position.round()
	get_parent().add_child(inst)
func _on_melee_damage_area_entered(area):
	if area.is_in_group("hitbox") && area.get_parent() != self:
		if area.get_parent().player || player:
			area.get_parent().damage(damage,position,knockback)
		else:
			area.get_parent().damage(damage * GameState.friendlyFire,position,knockback)


func _on_attack_range_area_entered(area):
	if area == GameState.theMonster.get_node("hitbox") :
		toAttack = true


func _on_attack_range_area_exited(area):
	if area == GameState.theMonster.get_node("hitbox") :
		toAttack = false
func damageAnimation():
	damageAnimation = !damageAnimation
	if damageAnimation:
		$Sprite.modulate = Color(2,2,2,1)
	else:
		$Sprite.modulate = Color(1,1,1,1)
	#shader.set_shader_param("white",damageAnimation)


func _on_VisibilityEnabler2D_screen_entered():
	visible = true


func _on_VisibilityEnabler2D_screen_exited():
	visible = false


func _on_ColliderOn_timeout():
	$CollisionShape2D.disabled = false

#switching logic
func _on_hitbox_input_event(viewport, event, shape_idx):
	if GameState.souls >= GameState.maxSouls && Input.is_action_just_pressed("switch") && !player:
		moving = true
		GameState.theMonster.player = false
		GameState.theMonster.switched()
		movingSpeed = speed * GameState.playerSpeedBoost
		$AttackOne.wait_time = attackOneCooldown / GameState.playerAttackSpeedBoost
		$AttackTwo.wait_time = attackTwoCooldown / GameState.playerAttackSpeedBoost
		#$Sprite.material = shader
		#GameState.theMonster.shader.set_shader_param("player",0.0)
		#connect("tookDamage",GameState.cameraMan,"shake")
		GameState.theMonster.get_node("Sprite").material = null
		$Sprite.material = GameState.outlineShader
		#shader.set_shader_param("player",1.0)
		$AttackOne.start()
		GameState.theMonster = self
		GameState.emit_signal("switch")
		player = true
		GameState.souls = 0
