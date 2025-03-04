extends Node

signal switch
signal newWave

var difficultyId:int = 1
var maxSouls:int = 1;
var souls:int = 1;
var theMonster
var wave:int = 0;
var monsterResource:int = 3
var random:RandomNumberGenerator= RandomNumberGenerator.new();
var playerSpeedBoost:float = 1.2
var playerAttackSpeedBoost:float = 1.5
var friendlyFire:float = 0.5
var cameraMan;
const monsterVals:Array = [
	{"name":"goblin","res":1},
	{"name":"chomps","res":1},
	{"name":"bullhead","res":2},
	{"name":"skeleton","res":1},
	{"name":"slime","res":1},
	{"name":"eyeball","res":1},
	{"name":"demon","res":2},
	{"name":"rockethead","res":2}
	]
onready var scene_switcher = get_tree().current_scene
onready var outlineShader = load("res://shaders/player.tres")
var cooldown;
func _ready():
	random.randomize()
func reset():
	print("reset")
	maxSouls = 1
	souls = 1
	wave = 0
	monsterResource = 3
