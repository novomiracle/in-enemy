extends CanvasLayer

signal retry
signal main_menu
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	connect("retry",GameState.scene_switcher,"retry")
	connect("main_menu",GameState.scene_switcher,"main_menu")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_retry_pressed():
	print("retry")
	emit_signal("retry")


func _on_main_menu_pressed():
	emit_signal("main_menu")
