extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var shakeStrength:float = 0
var speed = 100;
var movingSpeed;
var direction = Vector2.ZERO
var cameraOffset:Vector2 =  Vector2.ZERO
# Called when the node enters the scene tree for the first time.
func _ready():
	GameState.connect("switch",self,"switch")
	GameState.cameraMan = self

func switch():
	GameState.theMonster.connect("tookDamage",self,"shake")
	speed = GameState.theMonster.speed * GameState.playerSpeedBoost-5
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(GameState.theMonster != null):
		if position.distance_to(GameState.theMonster.position) >10:
			direction =  GameState.theMonster.position - position;
		else:
			direction = Vector2.ZERO
		if position.distance_to(GameState.theMonster.position) >90:
			movingSpeed = 150
		else:
			movingSpeed = speed
	move_and_slide(direction.normalized() * movingSpeed)
	shakeStrength= lerp(shakeStrength,0,3*delta)
	$Camera2D.offset = Vector2(GameState.random.randf_range(-shakeStrength,shakeStrength),GameState.random.randf_range(-shakeStrength,shakeStrength))
func shake():
	shakeStrength = 3
