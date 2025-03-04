extends CanvasLayer

signal retry
signal settings
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	connect("retry",GameState.scene_switcher,"retry")
	connect("settings",GameState.scene_switcher,"settings")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_retry_pressed():
	emit_signal("retry")



func _on_settings_pressed():
	emit_signal("settings")
