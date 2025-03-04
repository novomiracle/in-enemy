extends Node


# Declare member variables here. Examples:
# var a = 2
onready var monsterContainer = get_parent().get_node("monsterContainer");
# var b = "text"
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$waveMeter.value = 100 - $Timer.get_time_left()*20

func _on_Timer_timeout():
	GameState.emit_signal("newWave")
	GameState.wave+=1
	$Label.text =str(GameState.wave)
	GameState.maxSouls = floor(GameState.wave/3.0)+1
	GameState.monsterResource = 2+GameState.wave * 0.5

func _on_checkTimer_timeout():
	if monsterContainer.get_child_count() == 1 && $Timer.is_stopped():
		$Timer.start()
