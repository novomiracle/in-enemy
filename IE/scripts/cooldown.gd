extends TextureProgress

var a = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	GameState.connect("switch",self,"switch")
	max_value = 2/GameState.playerAttackSpeedBoost * 10
	GameState.cooldown = self
	#GameState.theMonster.connect("attack1",self,"attack1")
	#max_value = (GameState.theMonster.attackOneCooldown/ GameState.playerAttackSpeedBoost) *10

# Called every frame. 'delta' is the elapsed time since the previous frame.
func switch():
	max_value = (GameState.theMonster.attackOneCooldown/ GameState.playerAttackSpeedBoost) *10
	GameState.theMonster.connect("attack1",self,"reset")
func reset():
	value = 0
func _on_Timer_timeout():
	value += 1
