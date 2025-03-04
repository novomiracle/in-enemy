extends TextureButton


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var difficulties = [
	{
		"name":"easy",
		"playerSpeedBoost":1.5,
		"playerAttackSpeedBoost":2.0,
		"friendlyFire":1
	},
	{
		"name":"normal",
		"playerSpeedBoost":1.2,
		"playerAttackSpeedBoost":1.5,
		"friendlyFire":0.5
	},
	{
		"name":"hard",
		"playerSpeedBoost":1,
		"playerAttackSpeedBoost":1,
		"friendlyFire":0
	},
	{
		"name":"extreme",
		"playerSpeedBoost":0.8,
		"playerAttackSpeedBoost":0.6,
		"friendlyFire":0
	}
]
# Called when the node enters the scene tree for the first time.
func _ready():
	$Label.text =difficulties[GameState.difficultyId]["name"]


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_pressed():
	GameState.difficultyId+=1
	if GameState.difficultyId >= difficulties.size():
		GameState.difficultyId = 0
	GameState.playerAttackSpeedBoost = difficulties[GameState.difficultyId]["playerAttackSpeedBoost"]
	GameState.playerSpeedBoost = difficulties[GameState.difficultyId]["playerSpeedBoost"]
	GameState.friendlyFire = difficulties[GameState.difficultyId]["friendlyFire"]
	$Label.text = difficulties[GameState.difficultyId]["name"]
