extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var monsterContainer = get_parent().get_node("monsterContainer");
var resource:int
export var monsterName:String = "";
const monsterCount = 7
# Called when the node enters the scene tree for the first time.
func _ready():
	GameState.connect("newWave",self,"monster")
	resource = GameState.monsterResource
	
func monster():
	while resource > 0:
		var mon = GameState.monsterVals[GameState.random.randi_range(0,monsterCount)];
		while(mon["res"] > resource):
			mon = GameState.monsterVals[GameState.random.randi_range(0,monsterCount)]
		spawn(mon["name"])
		resource -= mon["res"]
	resource = GameState.monsterResource
func spawn(monster:String):
	var scene = load("res://monsters/"+monster+".tscn")
	var instance = scene.instance()
	instance.position = position + Vector2(GameState.random.randi_range(-10,10),GameState.random.randi_range(-10,10))
	monsterContainer.add_child(instance)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
