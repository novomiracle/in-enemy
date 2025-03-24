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
onready var monsterVals:Array = [
	{"name":"goblin","res":1,"load":load("res://monsters/goblin.tscn")},
	{"name":"chomps","res":1,"load":load("res://monsters/chomps.tscn")},
	{"name":"bullhead","res":2,"load":load("res://monsters/bullhead.tscn")},
	{"name":"skeleton","res":1,"load":load("res://monsters/skeleton.tscn")},
	{"name":"slime","res":1,"load":load("res://monsters/slime.tscn")},
	{"name":"eyeball","res":1,"load":load("res://monsters/eyeball.tscn")},
	{"name":"demon","res":2,"load":load("res://monsters/demon.tscn")},
	{"name":"rockethead","res":2,"load":load("res://monsters/rockethead.tscn")}
	]
onready var scene_switcher = get_tree().current_scene
onready var soulScene = load("res://scenes/soul.tscn")
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
